module Line
  class AuthenticationsController < Line::BaseController
    layout 'line/layouts/line_login'
    skip_before_action :validate_signature

    def link
      # TODO: hidden_fieldを使う形では問題があるのでは？
      @link_token = params[:linkToken]
    end

    def create
      # 3. 自社サービスのユーザーIDを取得する
      user = login(params[:email], params[:password])

      if user
        user_id = current_user.id
        link_token = params[:link_token]

        # 4. nonceを生成してユーザーをLINEプラットフォームにリダイレクトする
        nonce = SecureRandom.urlsafe_base64(16)
        session[:nonce] = { nonce => user_id }
        Rails.logger.debug "Sessions nonce: #{ session[:nonce].keys[0] }"

        redirect_to "https://access.line.me/dialog/bot/accountLink?linkToken=#{link_token}&nonce=#{nonce}"
      else
        flash.now[:danger] = "ログイン失敗"
        render :link
      end
    end
  end
end
