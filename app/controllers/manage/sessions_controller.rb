module Manage
  class SessionsController < ::Devise::SessionsController
    layout "manage/sign_in"

  end
end

