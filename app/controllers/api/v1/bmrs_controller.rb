# frozen_string_literal: true

module Api
  module V1
    class BmrsController < Api::V1::BaseController
      before_action :set_user

      # TODO: 1アクションの中で2度updateしている、要リファクタリング
      def update
        if @user.update(bmr_params)
          bmr = @user.calc_bmr.floor
          @user.update!(bmr: bmr)

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
