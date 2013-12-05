require_dependency "manage/application_controller"
require_dependency 'kaminari'

class Manage::ResourceController < Manage::ApplicationController
  inherit_resources

  cattr_accessor :per_page

  self.responder = Manage::Responder

  layout 'manage/application'

  respond_to :html

  helper_method :list_index_fields, :list_edit_fields, :list_search_fields

  def end_of_association_chain
    if self.resources_configuration[:self][:search_fields].blank?
      self.class.search_fields :all
    end

    config = self.resources_configuration[:self]
    @search = config[:search].new(params[:f])

    @search.results 
  end

  protected
  def collection
    assocation = end_of_association_chain.page(params[:page] || 1)
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
    config[:search] = Class.new do
      include SearchObject.module(:model, :sorting)

      def escape_search_term(term)
        "%#{term.gsub(/\s+/, '%')}%"
      end

      def parse_date(date)
        Date.strptime(date, '%Y-%m-%d') rescue nil
      end

    end
    config[:search].scope { resource_class.all }

    Object.const_set("#{'Bla'.to_s}", config[:search])

    config[:search_fields].select {|f| not f.to_s.include?('.')}.each do |field|
      field_type = resource_class.columns_hash[field.to_s].type
      if field_type == :text or field_type == :string
        config[:search].option field.to_sym do |scope, value|
          scope.where "#{field.to_s} LIKE ?", escape_search_term(value)
        end
      elsif field_type == :datetime
        config[:search].option field.to_sym do |scope, value|
          date = parse_date value
          scope.where("DATE(#{field.to_s}) >= ?", date) if date.present?
        end
      elsif field_type == :integer
        config[:search].option field.to_sym
      else
        config[:search].option field.to_sym do |scope, value|
          scope.where "#{field.to_s} LIKE ?", escape_search_term(value)
        end
      end
    end
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

  private
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

  def list_fields(key)
    if self.resources_configuration[:self][key].blank?
      resource_class.attribute_names - %w(id created_at updated_at)
    else
      self.resources_configuration[:self][key]
    end
  end

end
