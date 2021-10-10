# frozen_string_literal: true

module Line
  class BaseController < ApplicationController
    require 'line/bot'

    def client
      @client ||= Line::Bot::Client.new { |config|
        config.channel_id = Rails.application.credentials.line[:CHANNEL_ID]
        config.channel_secret = Rails.application.credentials.line[:CHANNEL_SECRET]
        config.channel_token = Rails.application.credentials.line[:CHANNEL_TOKEN]
      }
    end
  end
end
