require_dependency "manage/application_controller"
require_dependency 'kaminari'

class Manage::ResourceController < Manage::ApplicationController
  inherit_resources

  cattr_accessor :per_page

  self.responder = Manage::Responder

  layout 'manage/application'

  respond_to :html

  protected
  def collection
    assocation = end_of_association_chain.page(params[:page] || 1)
    per_page ? assocation.per(per_page) : assocation
  end

  def permitted_params
    params.permit!
  end

end
