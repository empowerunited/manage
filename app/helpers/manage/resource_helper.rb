module Manage
  module ResourceHelper
    def index_attributes
      list_index_fields
    end

    def edit_attributes
      list_edit_fields
    end

    def attributes
      resource_class.attribute_names - %w(id created_at updated_at)
    end

    def attribute_value(scope, attr)
      prefix_attr, rest_attr, custom_query, custom_format = _parse_attribute(attr)
      value = scope.public_send(prefix_attr)

      if value.is_a?(ActiveRecord::Associations::CollectionProxy )
        if rest_attr.empty?
          value = custom_query.present? ? custom_query.call(value) : value

          value.map do |entity|
            ("<a href=\"#{prefix_attr}/#{entity.id}\">#{custom_format.present? ? custom_format.call(entity) : entity.id }</a>")
          end.join(', ').html_safe
        else
          value.map do |entity|
            attribute_value(entity, rest_attr.join('.'))
          end.join(', ')
        end
      else
        rest_attr.empty? ? value.to_s : attribute_value(value, rest_attr.join('.'))
      end

    end

    def attribute_header(resource_class, attr, prefix='')
      prefix_attr, rest_attr = _parse_attribute(attr)
      header = resource_class.human_attribute_name(prefix_attr)

      rest_attr.empty? ? prefix + header : attribute_header(resource_class, rest_attr.join('.'), prefix + header + ' ')
    end

    private
    def _parse_attribute(attr)
      custom_query = nil
      custom_format = nil

      if attr.is_a?(Hash)
        prefix_attr = attr.keys.first
        rest_attr = attr[prefix_attr]

        if rest_attr.is_a?(String)
          rest_attr = Array(rest_attr)
        else
          custom_query = attr[prefix_attr][:query]
          custom_format = attr[prefix_attr][:format]
          rest_attr = []
        end
      else
        prefix_attr, *rest_attr = attr.to_s.split('.')
      end

      return prefix_attr, rest_attr, custom_query, custom_format
    end

  end
end
