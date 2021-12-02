# frozen_string_literal: true

module Api
  module V1
    class BmrsController < Api::V1::BaseController
      def update
        current_user.assign_attributes(bmr_params)
        current_user.bmr = current_user.calc_bmr.floor

        if current_user.save
          render json: { bmr: current_user.bmr, pfc_params: current_user.set_attributes_for_pfc }
        else
          render400(nil, current_user.errors.full_messages)
        end
      end

      private

        def bmr_params
          params.require(:user).permit(:gender, :birth, :height, :weight)
        end
    end
  end
end
