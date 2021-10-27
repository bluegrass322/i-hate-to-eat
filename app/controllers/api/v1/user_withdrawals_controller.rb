module Api
  module V1
    class UserWithdrawalsController < Api::V1::BaseController
      def show
        u = current_user
        render json: { id: u.id, name: u.name }
      end

      def destroy
        user = User.find(params[:id])
        logout

        user.destroy!
        head :ok
      end
    end
  end
end