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
      Fields::Reader.field_value(scope, field_data)
    end

    def field_title(resource_class, field_data)
      Fields::Reader.field_title(resource_class, field_data)
    end

  end
end
