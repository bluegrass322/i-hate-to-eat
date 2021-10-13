module Line
  class AuthenticationsController < Line::BaseController
    skip_before_action :validate_signature
    before_action :token_params
    # before_action :logout_current_user

    layout 'line/layouts/line_login'

    def link; end

    def create
      @user = login(params[:email], params[:password])

      if @user
        user_id = current_user.id
        # TODO: デバッグ用、忘れず削除
        Rails.logger.debug "user_id: #{ user_id }"
        Rails.logger.debug "linkToken: #{ @link_token }"

        # nonce生成
        # { nonce: user_id }で保存（nonce用のカラムを追加？連携が完了したら削除する）
        # lineプラットフォームにリダイレクト（linkToken + nonce)
        # 成功したらアカウント連携イベントが帰ってくる
        # linebotコントローラーへ

        redirect_to "https://i-hate-to-eat.herokuapp.com/register"
      else
        flash.now[:danger] = "ログイン失敗"
        render :link
      end
    end

    private

      # def logout_current_user
      #   logout if logged_in?
      # end

      def token_params
        @link_token = params[:linkToken]
      end
  end
end
