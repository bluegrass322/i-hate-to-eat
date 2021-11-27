# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      before_action :require_login

      # TODO: エラーハンドリングをどこに置く？
      rescue_from StandardError, with: :render500
      rescue_from ActiveRecord::RecordNotFound, with: :render404

      private

        def render400(exception = nil, messages = nil)
          render_error(400, "Bad Request", exception&.message, *messages)
        end

        def render404(exception = nil, messages = nil)
          render_error(404, "Record Not Found", exception&.message, *messages)
        end

        def render500(exception = nil, messages = nil)
          render_error(500, "Internal Server Error", exception&.message, *messages)
        end

        def render_error(code, message, *error_messages)
          response = {
            message: message,
            errors: error_messages.compact
          }

          render json: response, status: code and return
        end

        def not_authenticated
          redirect_to root_path
        end
    end
  end
end
