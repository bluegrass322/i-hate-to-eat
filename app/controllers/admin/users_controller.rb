class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all.order(created_at: "DESC")
  end

  def show; end

  def edit; end
  
  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "ユーザー情報の更新に成功"
    else
      flash.now[:danger] = "ユーザーの更新に失敗"
      render :edit
    end
  end

  def destroy
    @user.destroy!
    redirect_to admin_users_path, notice: "ユーザーの削除に成功"
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :pasword_confirmation,
                                   :role)
    end
end
