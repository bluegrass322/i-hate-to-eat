module Line
  class AuthenticationsController < Line::BaseController
    skip_before_action :validate_signature

    layout 'line/layouts/line_login'

    def link
      token_params
      puts "linkToken#link: #{ @link_token }"
    end

    def create
      # 3. 自社サービスのユーザーIDを取得する
      @user = login(params[:email], params[:password])

      if @user
        user_id = current_user.id
        # TODO: デバッグ用、忘れず削除
        puts "linkToken#create: #{ @link_token }"

        # nonce生成
        # { nonce: user_id }で保存（nonce用のカラムを追加？連携が完了したら削除する）
        # lineプラットフォームにリダイレクト（linkToken + nonce)
        # 成功したらアカウント連携イベントが帰ってくる
        # linebotコントローラーへ

        # redirect_to "https://i-hate-to-eat.herokuapp.com/register"
      else
        flash.now[:danger] = "ログイン失敗"
        render :link
      end
    end

    private

      def token_params
        @link_token = params[:linkToken]
      end
  end
end
