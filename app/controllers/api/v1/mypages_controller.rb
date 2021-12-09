# frozen_string_literal: true

module Api
  module V1
    class MypagesController < Api::V1::BaseController
      def show
        mypage_params = current_user.mypage_params
        render json: mypage_params
      end
    end
  end
end
