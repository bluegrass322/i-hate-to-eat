# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      include ExceptionHandler

      before_action :require_login

      private

        def not_authenticated
          render400(nil, "ログインしてください")
        end
    end
  end
end
