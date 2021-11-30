# frozen_string_literal: true

module Api
  module V1
    class MypagesController < Api::V1::BaseController
      before_action :set_user

      def show
        mypage_params = @user.set_mypage_params
        render json: mypage_params
      end

      private

        def set_user
          @user = User.find(current_user.id)
        end
    end
  end
end
