class Manage::ApplicationController < ActionController::Base
  # before_filter :authenticate_admin_user!
  before_filter :authenticate_admin

  def authenticate_admin
    authenticate_or_request_with_http_basic do |username, password|
      @current_admin_user = AdminUser.where(email: username).first
      return request_http_basic_authentication if @current_admin_user.blank?
      return request_http_basic_authentication unless @current_admin_user.valid_password?(password)
      @current_admin_user
    end
  end

  helper_method :current_admin_user
  def current_admin_user
    @current_admin_user
  end

end
