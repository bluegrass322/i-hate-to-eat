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

      if login_user
        link_token = params[:link_token]
 
        # 連携手順4. nonceを生成してユーザーをLINEプラットフォームにリダイレクトする
        nonce = SecureRandom.urlsafe_base64(16)

        begin
          binding.pry
          login_user.update!(line_nonce: nonce)
        rescue => e
          Rails.logger.error "#{e}"
        end
        Rails.logger.debug "UserNonce: #{login_user.line_nonce}"

        # uri = URI("https://access.line.me/dialog/bot/accountLink")
        # uri.query = URI.encode_www_form({ linkToken: link_token, nonce: nonce })
        # redirect_to uri

        redirect_to "https://access.line.me/dialog/bot/accountLink?linkToken=#{link_token}&nonce=#{nonce}"
      else
        flash.now[:danger] = "ログイン失敗"
        render :link
      end
    end
  end
end
