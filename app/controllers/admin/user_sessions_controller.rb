module Admin
  class UserSessionsController < Admin::BaseController
    skip_before_action :check_admin
    skip_before_action :require_login
  end
end
