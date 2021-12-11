module Line
  class AuthenticationsController < Line::BaseController
    layout 'line/layouts/line_login'
    skip_before_action :validate_signature

    def link
      # TODO: hidden_fieldを使う形では問題があるのでは？
      @link_token = params[:linkToken]
    end

    def create
      Rails.logger.error "Params: #{params[:name]}#{params[:password]}"
      # 連携手順3. 自社サービスのユーザーIDを取得する
      login_user = login(params[:name], params[:password])
      Rails.logger.error "User: #{login_user}"

      if login_user
        link_token = params[:link_token]
        Rails.logger.error "LinkToken: #{link_token}'"
 
        # 連携手順4. nonceを生成してユーザーをLINEプラットフォームにリダイレクトする
        nonce = SecureRandom.urlsafe_base64(16)
        Rails.logger.error "Nonce: #{nonce}'"
        login_user.update!(line_nonce: nonce)

        uri = URI("https://access.line.me/dialog/bot/accountLink")
        uri.query = URI.encode_www_form({ linkToken: link_token, nonce: nonce })
        Rails.logger.error "URI: #{uri}'"

        redirect_to uri
      else
        flash.now[:danger] = "ログイン失敗"
        render :link
      end
    end
  end
end
