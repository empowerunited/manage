module Manage
  module ResourceHelper
    def index_fields
      list_index_fields
    end

    def edit_fields
      list_edit_fields
    end

    def attributes
      resource_class.attribute_names - %w(id created_at updated_at)
    end

    def field_value(scope, field_data)
      Fields::Reader.field_value(scope, field_data).to_s
    end

    def field_title(resource_class, field_data)
      Fields::Reader.field_title(resource_class, field_data)
    end

    def action_link(scope, link_data)
      value = nil

      if link_data.is_a? (Hash)
        relation = link_data.keys.first
        entity = Fields::Reader.field_value(scope, relation)
        unless entity.present?
          return ''
        end
        if link_data[relation][:label_field].present?
          value = field_value(scope, link_data[relation][:label_field])
        elsif link_data[relation][:label].present?
          value = link_data[relation][:label]
        end

        path = entity.class.name.dasherize.pluralize.downcase
        return  link_to value, [scope.public_send(relation)]
      end

      if link_data.is_a? (Symbol) or link_data.is_a?(String)
        relation = link_data.to_s
        assocation = scope.class.reflect_on_association(link_data.to_sym)
        raise "assocation #{link_data} not found on #{scope.class}" unless assocation
        if assocation.options[:class_name].present?
          rel_name = scope.class.reflect_on_association(link_data.to_sym).options[:class_name]
          relation = rel_name.downcase.dasherize.pluralize
        end
        if scope.class.reflect_on_association(link_data.to_sym).options[:as].present?
          key = scope.class.reflect_on_association(link_data.to_sym).options[:as].to_s + '_id'
        else
          key = scope.class.name.downcase.dasherize + '_id'
        end
        return "<a href=\"#{relation}?f%5B#{key}%5D=#{scope.id}\">#{resource_class.human_attribute_name(link_data.to_s)}</a>".html_safe
      end

      unless value
        raise 'Unsupported link data'
      end

    end

  end
end
