# frozen_string_literal: true

module Api
  module V1
    class BmrsController < Api::V1::BaseController
      before_action :set_user

      def show
        attributes = @user.set_attributes_for_bmr
        json_string = attributes.to_json

        render json: json_string
      end

      # TODO: 1アクションの中で2度updateしている、要リファクタリング
      def update
        if @user.update(bmr_params)
          bmr = @user.calc_bmr.floor
          @user.update!(bmr: bmr)

          render json: { bmr: @user.bmr }
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
