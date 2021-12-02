# frozen_string_literal: true

module Api
  module V1
    class UserWithdrawalsController < Api::V1::BaseController
      def show
        render json: { id: current_user.id, name: current_user.name }
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
