module Api
  module V1
    class UserWithdrawalsController < Api::V1::BaseController
      def show
        id = current_user.id
        name = current_user.name

        render json: { id: id, name: name }
      end

      def destroy
        current_user.destroy!
        # セッションの削除
        head :ok
      end
    end
  end
end