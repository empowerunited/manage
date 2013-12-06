module Manage
  class SessionsController < ::Devise::SessionsController
    layout "manage/sign_in"

    def destroy
      p 'what?'
      super
    end
  end
end

