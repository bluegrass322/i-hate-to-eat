module Api
  module V1
    class UserWithdrawalController < Api::V1::BaseController
      def show
        name = current_user.name
        render json: { name: name }
      end

      def destroy
        current_user.destroy!
        head :ok
      end
    end
  end
end