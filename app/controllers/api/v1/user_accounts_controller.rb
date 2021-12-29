# frozen_string_literal: true

module Api
  module V1
    class UserAccountsController < Api::V1::BaseController
      def show
        attributes = current_user.account_params
        render json: attributes
      end

      def update
        if current_user.update(user_params)
          head :ok
        else
          render400(nil, current_user.errors.full_messages)
        end
      end

      private

        def user_params
          params.require(:user).permit(:name, :email, :line_notification_enabled, :mealtime_first)
        end
    end
  end
end
