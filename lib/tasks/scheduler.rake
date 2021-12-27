# frozen_string_literal: true

require 'line/bot'
require "./app/lib/common/notificatable_to_admin"

def client
  Line::Bot::Client.new do |config|
    config.channel_secret = Rails.application.credentials.line[:CHANNEL_SECRET]
    config.channel_token = Rails.application.credentials.line[:CHANNEL_TOKEN]
  end
end

namespace :scheduler do
  desc "期限切れのsuggestionを削除"
  task destroy_expired_suggestions: :environment do
    include Common::NotificatableToAdmin

    User.find_each do |user|
      Suggestion.transaction do
        expired_suggestion = user.suggestions.where("expires_at < ?", Time.current)
        expired_suggestion.each(&:destroy!) if expired_suggestion.present?
      end
    rescue StandardError => e
      Rails.logger.error "User#{user.id}: Failed to destroy suggestions. Cause...'#{e}'"
      notice_to_admin("Suggestionの削除に失敗")
    end

    complete_message("destroy_expired_suggestions")
  end

  desc "ユーザーごとに当日の食事内容を新規作成"
  task create_suggestion: :environment do
    include Common::NotificatableToAdmin
    include SuggestionsCreatable

    User.find_each do |user|
      create_suggestions(user)
    end

    complete_message("create_suggestion")
  end

  desc "ユーザーの設定した時間に食事内容を通知"
  task notice_suggestion: :environment do
    t = Time.current
    time_now = t - (t.to_i % (60 * 30))

    User.wish_line_notice.find_each do |user|
      if user.mealtime_first.strftime('%R') == time_now.strftime('%R')
        to_id = user.line_user_id
        message = user.set_line_notification_template

        client.push_message(to_id, message)
      end
    end
  end

  desc "1週間のhealth_savingsの合計を通知"
  task notice_health_savings_for_this_week: :environment do
    # 週1回、特定の曜日にのみ通知が行われるよう
    next unless Time.zone.today.wday.zero?

    User.wish_line_notice.find_each do |user|
      to_id = user.line_user_id
      message = user.set_health_savings_this_week

      client.push_message(to_id, message)
    end

    complete_message("notice_health_savings")
  end

  # 以下動作テスト用のタスク
  desc "動作確認用"
  task test_scheduler: :environment do
    puts "Scheduler test is works."
  end

  desc "LINEプッシュメッセージ送信テスト"
  task push_line_message_test: :environment do
    require 'line/bot'

    User.linked_line.find_each do |user|
      to_name = user.name
      to_id = user.line_user_id
      bmr = user.bmr

      message = {
        type: "text",
        text: "#{to_name}さんのBMR: #{bmr}kcal"
      }

      client = Line::Bot::Client.new do |config|
        config.channel_secret = Rails.application.credentials.line[:CHANNEL_SECRET]
        config.channel_token = Rails.application.credentials.line[:CHANNEL_TOKEN]
      end

      client.push_message(to_id, message)
    end
  end
end

# # 上限なくBMRを満たす分の提案を作成する場合
# # 食品の配列から合計カロリーを算出
# def sum_calories(foods)
#   foods.inject(0) do |sum, food|
#     sum + food.calorie * food.reference_amount
#   end
# end

# User.find_each do |user|
#   meal_menus = []

#   # ・主菜・主食をそれぞれ1つずつ追加
#   regular = Food.h_prio
#   main = Food.m_prio.maindish.order("RANDOM()").limit(1)
#   staple = Food.m_prio.staple_food.order("RANDOM()").limit(1)

#   meal_menus.concat(regular, main, staple)

#   # 合計カロリーがBMRに達するまで副菜を追加
#   # TODO: 無理矢理な計数ループ、要リファクタリング
#   bmr = user.bmr
#   loop = 0
#   while !@over_bmr && loop <= 50
#     # 重複を避けてサイドメニューを1つずつ取得
#     side = Food.where.not(id: meal_menus.map(&:id)).rm_prio.sidedish.order("RANDOM()").limit(1)
#     meal_menus.concat(side)

#     @over_bmr = sum_calories(meal_menus) > bmr
#     loop += 1
#   end

#   # 確定したメニューの内容をSuggestionのインスタンスとして保存
#   Suggestion.transaction do
#     meal_menus.each do |m|
#       item = user.suggestions.build(
#         food_id: m.id,
#         amount: m.reference_amount,
#         target_date: Time.zone.today,
#         expires_at: Time.current.end_of_day
#       )

#       item.save!
#     end
#   end
# end
