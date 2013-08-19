# class Devise::Users::SessionsController < Devise::SessionsController
class Manage::SessionsController < ::Devise::SessionsController
  layout "manage/sign_in"

end

