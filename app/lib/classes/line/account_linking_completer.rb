# frozen_string_literal: true

require './app/lib/linebot/linebot_base'

class AccountLinkingCompleter < LinebotBase
  def self.call(event)
    user = User.find_by(line_nonce: event.nonce.to_s)
    return reply_text("対象のユーザーが見つかりませんでした") unless user

    new(user, event).call
  end

  def call
    if User.exists?(line_user_id: @line_id)
      cancel_linking
    else
      save_line_id
      complete_message
    end
  end

  private

    def initialize(user, event)
      @user = user
      @line_id = event['source']['userId']
    end

    def cancel_linking
      @user.update!(line_nonce: nil)
      reply_text("すでに同じLINE-IDが登録されています")
    end

    def save_line_id
      @user.update!(line_user_id: @line_id, line_nonce: nil)
    end

    def complete_message
      [reply_text("アカウントの連携が完了しました"), reply_text("ようこそ、#{@user.name}さん")]
    end
end
