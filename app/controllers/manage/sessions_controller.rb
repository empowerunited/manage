module Manage
  class SessionsController < ::Devise::SessionsController
    layout "manage/sign_in"

    def destroy
      super
    end
  end
end

