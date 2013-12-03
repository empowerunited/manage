require_dependency "manage/application_controller"
require_dependency 'kaminari'

class Manage::ResourceController < Manage::ApplicationController
  inherit_resources

  cattr_accessor :per_page

  self.responder = Manage::Responder

  layout 'manage/application'

  respond_to :html

  helper_method :list_index_fields, :list_edit_fields

  protected
  def collection
    assocation = end_of_association_chain.page(params[:page] || 1)
    per_page ? assocation.per(per_page) : assocation
  end

  def permitted_params
    params.permit!
  end

  def self.setup_fields(key, *fields)
    # :all means all the fields - default
    if fields.first.to_sym == :all
      options = fields.extract_options!
      options[:except] ||= []
      options[:include] ||= []

      self.resources_configuration[:self][key] = (resource_class.attribute_names + Array(options[:include])) - Array(options[:except]).map(&:to_s) 
    else
      self.resources_configuration[:self][key] = fields
    end
  end

  def self.index_fields(*fields)
    setup_fields(:index_fields, *fields)
  end

  def self.edit_fields(*fields)
    setup_fields(:edit_fields, *fields)
  end

  def list_fields(key)
    if self.resources_configuration[:self][key].blank?
      resource_class.attribute_names - %w(id created_at updated_at)
    else
      self.resources_configuration[:self][key]
    end
  end

  def list_index_fields
    list_fields(:index_fields)
  end

  def list_edit_fields
    list_fields(:edit_fields)
  end

end
