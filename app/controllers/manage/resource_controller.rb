require_dependency "manage/application_controller"

class Manage::ResourceController < Manage::ApplicationController
  inherit_resources

  self.responder = Manage::Responder

  layout 'manage/application'

  has_scope :page, default: 1

  respond_to :html

  def permitted_params
    params.permit!
  end
end
