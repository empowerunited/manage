class Manage::ApplicationController < ActionController::Base
  # before_filter :authenticate_admin_user!
  before_filter :authenticate_admin

  def authenticate_admin
    authenticate_or_request_with_http_basic do |username, password|
      @current_user = AdminUser.where(email: username).first
      return request_http_basic_authentication if @current_user.blank?
      return request_http_basic_authentication unless @current_user.valid_password?(password)
      @current_user
    end
  end

  helper_method :current_user
  def current_user
    @current_user
  end

end
