module Manage
  module Fields
    class Filter
      class << self
        def field_value(scope, field_data)
          current_field, rest_field_parts, custom_query, custom_format = _parse_field_data(field_data)
          value = scope.public_send(current_field)

          if _is_field_relation?(value)
            value = custom_query.present? ? custom_query.call(value) : value

            value.map do |entity|
              ("<a href=\"#{current_field}/#{entity.id}\">#{custom_format.present? ? custom_format.call(entity) : entity.id }</a>")
            end.join(', ').html_safe
          else
            rest_field_parts.empty? ? value.to_s : field_value(value, rest_field_parts.join('.'))
          end
        end

        def field_title(resource_class, field_data, prefix='')
          current_field, rest_field_parts = _parse_field_data(field_data)
          title = resource_class.human_attribute_name(current_field)

          rest_field_parts.empty? ? prefix + title : field_title(resource_class, rest_field_parts.join('.'), prefix + title + ' ')
        end

        private
        def _is_field_relation?(field_value)
          field_value.is_a?(ActiveRecord::Associations::CollectionProxy)
        end

        def _parse_field_data(field_data)
          custom_query = nil
          custom_format = nil

          if field_data.is_a?(Hash)
            current_field = field_data.keys.first
            rest_field_parts = field_data[current_field]

            if rest_field_parts.is_a?(String)
              rest_field_parts = Array(rest_field_parts)
            else
              custom_query = field_data[current_field][:query]
              custom_format = field_data[current_field][:format]
              rest_field_parts = []
            end
          else
            current_field, *rest_field_parts = field_data.to_s.split('.')
          end

          return current_field, rest_field_parts, custom_query, custom_format
        end

      end
    end
  end
end
