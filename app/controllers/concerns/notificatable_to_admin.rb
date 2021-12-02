# frozen_string_literal: true

module NotificatableToAdmin
  require 'line/bot'
  extend ActiveSupport::Concern

  def notice_to_admin(text)
    message = set_message(text)
    client.push_message(admin_line_id, message)
  end

  def complete_message(task_name)
    text = "#{task_name}が正常に終了"
    message = set_message(text)

    client.push_message(admin_line_id, message)
  end

  private

    def admin_line_id
      Rails.application.credentials.admin[:LINE_ID]
    end

    def client
      Line::Bot::Client.new do |config|
        config.channel_secret = Rails.application.credentials.line[:CHANNEL_SECRET]
        config.channel_token = Rails.application.credentials.line[:CHANNEL_TOKEN]
      end
    end

    def set_message(text)
      date_time = Time.current.strftime("%c")
      { type: "text", text: "#{date_time}\n#{text}" }
    end
end
