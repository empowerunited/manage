module Manage
  class SessionsController < ::Devise::SessionsController
    layout "manage/sign_in"

    def destroy
      super
    end

    def after_sign_in_path_for(resource)
      signed_in_root_path(resource)
    end
  end
end

