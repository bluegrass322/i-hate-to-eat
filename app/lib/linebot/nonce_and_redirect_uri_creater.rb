# frozen_string_literal: true

require './app/lib/linebot/linebot_base'

class NonceAndRedirectUriCreater < LinebotBase
  def self.call(user, link_token)
    new(user, link_token).call
  end

  def call
    nonce = urlsafe_nonce
    save_nonce(nonce)

    redirect_uri(nonce)
  end

  private

    def initialize(user, link_token)
      @user = user
      @link_token = link_token
    end

    # 連携手順4. nonceを生成してユーザーをLINEプラットフォームにリダイレクトする
    def urlsafe_nonce
      SecureRandom.urlsafe_base64(16)
    end

    def save_nonce(nonce)
      @user.update!(line_nonce: nonce)
    end

    def redirect_uri(nonce)
      uri = URI("https://access.line.me/dialog/bot/accountLink")
      uri.query = URI.encode_www_form({ linkToken: @link_token, nonce: nonce })

      uri.to_s
    end
end
