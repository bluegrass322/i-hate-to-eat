# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    before_action :require_login, :check_admin

    layout 'admin/layouts/application'

    private

      def not_authenticated
        flash[:danger] = "ログインしてください"
        redirect_to admin_login_path
      end

      def check_admin
        redirect_to(root_path) unless current_user.admin?
      end
  end
end
