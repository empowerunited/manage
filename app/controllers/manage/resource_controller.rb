require_dependency "manage/application_controller"
require_dependency 'kaminari'

class Manage::ResourceController < Manage::ApplicationController
  inherit_resources

  cattr_accessor :per_page

  self.responder = Manage::Responder

  layout 'manage/application'

  respond_to :html

  helper_method :list_index_fields, :list_edit_fields, :list_search_fields, :list_action_links, :resource_actions, :collection_actions, :'default_actions?'

  def end_of_association_chain
    if self.resources_configuration[:self][:search_fields].blank?
      self.class.search_fields :all
    end

    config = self.resources_configuration[:self]
    @search = config[:search].new(clean_search_params(params[:f]))

    @search.results
  end

  protected

  def clean_search_params(search_params)
    return {} unless search_params.is_a?(Hash)
    search_params = search_params.dup
    search_params.delete_if do |key, value|
      value == ''
    end
    search_params
  end

  def self.collection_scope lambda
    @@collection_scope = lambda
  end

  def collection
    filtered_collection = end_of_association_chain
    if defined?(@@collection_scope) and @@collection_scope.present?
      filtered_collection = @@collection_scope.call(filtered_collection)
    end

    assocation = filtered_collection.page(params[:page] || 1)
    per_page ? assocation.per(per_page) : assocation
  end

  def permitted_params
    params.permit!
  end

  def self.index_fields(*fields)
    setup_fields(:index_fields, *fields)
  end

  def self.edit_fields(*fields)
    setup_fields(:edit_fields, *fields)
  end

  def self.search_fields(*fields)
    setup_fields(:search_fields, *fields)

    config = self.resources_configuration[:self]
    config[:search] = Manage::Fields::Searcher.generate_search_object(resource_class, config[:search_fields])
  end

  def self.action_links(*fields)
    setup_fields(:action_links, *fields)
  end

  def list_index_fields
    list_fields(:index_fields)
  end

  def list_edit_fields
    list_fields(:edit_fields)
  end

  def list_search_fields
    list_fields(:search_fields)
  end

  def list_action_links
    if self.resources_configuration[:self][:action_links].blank?
      []
    else
      self.resources_configuration[:self][:action_links]
    end
  end

  # Don't display the show, edit, delete in the index view
  def default_actions?
    true
  end

  #
  # This doubles the list_action_links.
  # It provides actions on existing resource.
  # actions are used in index/show/edit screens
  # returns html string
  def resource_actions resource
    nil
  end

  # This method provides links on which to submit all collection / selected items
  # Example:
  #
  def collection_actions resource
    nil
  end

  private
  def self.setup_fields(key, *fields)
    # :all means all the fields - default
    if not fields.first.is_a?(Hash) and fields.first.to_sym == :all
      options = fields.extract_options!
      options[:except] ||= []
      options[:include] ||= []

      self.resources_configuration[:self][key] = (resource_class.attribute_names + Array(options[:include])) - Array(options[:except]).map(&:to_s)
    else
      self.resources_configuration[:self][key] = fields
    end
  end

  def list_fields(key)
    if self.resources_configuration[:self][key].blank?
      resource_class.attribute_names - %w(id created_at updated_at)
    else
      self.resources_configuration[:self][key]
    end
  end

end
