# frozen_string_literal: true

module Line
  class BaseController < ApplicationController
    require 'line/bot'
    include Api::ExceptionHandler

    before_action :validate_signature

    def client
      @client ||= Line::Bot::Client.new { |config|
        config.channel_id = Rails.application.credentials.line[:CHANNEL_ID]
        config.channel_secret = Rails.application.credentials.line[:CHANNEL_SECRET]
        config.channel_token = Rails.application.credentials.line[:CHANNEL_TOKEN]
      }
    end

    def validate_signature
      @body = request.body.read

      signature = request.env['HTTP_X_LINE_SIGNATURE']
      unless client.validate_signature(@body, signature)
        # TODO: エラーの出し方を修正
        error 400 do 'Bad Request' end
      end
    end
  end
end
