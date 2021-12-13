
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

        uri = Line::NonceAndRedirectUriCreater.call(login_user, link_token)

        redirect_to uri
      else
        flash.now[:danger] = "ログイン失敗"
        render :link
      end
    end
  end
end
