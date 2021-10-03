class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all.order(created_at: "DESC")
  end

  def show; end

  private

    def set_user
      @user = User.find(params[:id])
    end
end
