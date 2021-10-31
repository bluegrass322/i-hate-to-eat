# frozen_string_literal: true

module Api
  module V1
    class RegistrationsController < Api::V1::BaseController
      include DriSetable
      skip_before_action :require_login

      def create
        user = User.new(user_params)

        dri = set_reference_intake(user)
        user.dietary_reference_intake_id = dri.id

        if user.save
          head :ok
        else
          render400(nil, user.errors.full_messages)
        end
      end

      private

        def user_params
          params.require(:user).permit(:name, :email, :gender, :birth, :password, :password_confirmation)
        end
    end
  end
end
