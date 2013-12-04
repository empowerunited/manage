class Manage::ApplicationController < ActionController::Base
  before_filter :auth_user!

  def auth_user!
    redirect_to new_admin_user_session_path unless admin_user_signed_in?
  end

  def current_user
    current_admin_user
  end

end
