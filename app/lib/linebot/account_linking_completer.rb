# frozen_string_literal: true

require './app/lib/linebot/linebot_base'

class AccountLinkingCompleter < LinebotBase
  def self.call(event)
    nonce = event.nonce.to_s
    linking_user = User.find_by(line_nonce: nonce)

    return reply_text("対象のユーザーが見つかりませんでした") unless linking_user

    line_id = event['source']['userId']

    new(linking_user, line_id).call
  end

  def call
    if User.exists?(line_user_id: @line_id)
      cancel_linking
    else
      save_line_id
      push_complete_message
      reply_text("アカウントの連携が完了しました")
    end
  end

  private

    def initialize(user, line_id)
      @user = user
      @line_id = line_id
    end

    def cancel_linking
      @user.update!(line_nonce: nil)
      reply_text("すでに同じLINE-IDが登録されています")
    end

    def save_line_id
      @user.update!(line_user_id: @line_id, line_nonce: nil)
    end

    def push_complete_message
      to_name = @user.name
      to_id = @user.line_user_id

      message = {
        type: "text",
        text: "ようこそ、#{to_name}さん"
      }

      client.push_message(to_id, message)
    end
end
