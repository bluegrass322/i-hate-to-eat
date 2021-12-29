# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      include Api::ExceptionHandler

      before_action :require_login
    end
  end
end
