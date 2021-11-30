# frozen_string_literal: true

module Api
  module V1
    class BmrsController < Api::V1::BaseController
      before_action :set_user

      def update
        @user.assign_attributes(bmr_params)
        @user.bmr = @user.calc_bmr.floor

        if @user.save
          render json: { bmr: @user.bmr, pfc_params: @user.set_attributes_for_pfc }
        else
          render400(nil, @user.errors.full_messages)
        end
      end

      private

        def set_user
          @user = User.find(current_user.id)
        end

        def bmr_params
          params.require(:user).permit(:gender, :birth, :height, :weight)
        end
    end
  end
end
