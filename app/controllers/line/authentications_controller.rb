module Line
  class AuthenticationsController < Line::BaseController
    layout 'line/layouts/line_login'
    skip_before_action :validate_signature

    def link
      # TODO: hidden_fieldを使う形では問題があるのでは？
      @link_token = params[:linkToken]
    end

    def create
      # 連携手順3. 自社サービスのユーザーIDを取得する
      login_user = login(params[:name], params[:password])
      Rails.logger.debug "User: #{login_user}"

      if login_user
        link_token = params[:link_token]
        Rails.logger.debug "LinkToken: #{link_token}"
 
        # 連携手順4. nonceを生成してユーザーをLINEプラットフォームにリダイレクトする
        nonce = SecureRandom.urlsafe_base64(16)
        Rails.logger.debug "Nonce: #{nonce}"

        login_user.update!(line_nonce: nonce)
        Rails.logger.debug "UserNonce: #{login_user.nonce}"

        uri = URI("https://access.line.me/dialog/bot/accountLink")
        uri.query = URI.encode_www_form({ linkToken: link_token, nonce: nonce })
        Rails.logger.debug "URI: #{uri}"

        redirect_to uri
      else
        flash.now[:danger] = "ログイン失敗"
        render :link
      end
    end
  end
end
