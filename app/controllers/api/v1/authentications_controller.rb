# frozen_string_literal: true

module Api
  module V1
    class AuthenticationsController < Api::V1::BaseController
      skip_before_action :require_login

      def create
        @user = login(params[:email], params[:password])

        if @user
          render json: { id: @user.id }
        else
          render400(nil, "ログインに失敗しました")
        end
      end

      def destroy
        logout
        head :ok
      end
    end
  end
end
