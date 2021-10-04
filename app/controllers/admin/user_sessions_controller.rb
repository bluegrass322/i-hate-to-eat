module Admin
  class UserSessionsController < Admin::BaseController
    skip_before_action :check_admin
    skip_before_action :require_login

    layout 'admin/layouts/admin_login'

    def new; end

    def create
      @user = login(params[:email], params[:password])

      if @user
        redirect_to admin_root_path, notice: "ログイン成功"
      else
        flash.now[:danger] = "ログイン失敗"
        render :new
      end
    end

    def destroy
      logout
      redirect_to admin_login_path, notece: "ログアウト成功"
    end
  end
end
