module Line
  class AuthenticationsController < Line::BaseController
    skip_before_action :validate_signature

    layout 'line/layouts/line_login'

    def link
      @link_token = params[:linkToken]
    end

    def create
      # 3. 自社サービスのユーザーIDを取得する
      user = login(params[:email], params[:password])
      link_token = params[:link_token]

      if user
        user_id = current_user.id

        # nonce生成
        # { nonce: user_id }で保存（nonce用のカラムを追加？連携が完了したら削除する）
        # lineプラットフォームにリダイレクト（linkToken + nonce)
        # 成功したらアカウント連携イベントが帰ってくる
        # linebotコントローラーへ

        # TODO: リダイレクト確認用に一時的に設置
        redirect_to "https://i-hate-to-eat.herokuapp.com/register"
      else
        flash.now[:danger] = "ログイン失敗"
        render :link
      end
    end
  end
end
