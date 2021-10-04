# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    before_action :require_login

    layout 'admin/layouts/application'
  end
end
