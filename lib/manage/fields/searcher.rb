module Manage
  module Fields
    class Searcher
      class << self
        def generate_search_object(resource_class, search_fields)
          search_class = Class.new do
            include SearchObject.module(:model, :sorting)

            def escape_search_term(term)
              "%#{term.gsub(/\s+/, '%')}%"
            end

            def parse_date(date)
              Date.strptime(date, '%Y-%m-%d') rescue nil
            end
          end


          search_class.scope { resource_class.all }
          Object.const_set("#{resource_class.name + 'Searcher'}", search_class)

          search_fields.select {|f| not f.to_s.include?('.')}.each do |field|
            field_type = resource_class.columns_hash[field.to_s].type
            if field_type == :text or field_type == :string
              search_class.option field.to_sym do |scope, value|
                scope.where "#{field.to_s} LIKE ?", escape_search_term(value)
              end
            elsif field_type == :datetime
              search_class.option field.to_sym do |scope, value|
                date = parse_date value
                scope.where("DATE(#{field.to_s}) >= ?", date) if date.present?
              end
            elsif field_type == :integer
              search_class.option field.to_sym
            else
              search_class.option field.to_sym do |scope, value|
                scope.where "#{field.to_s} LIKE ?", escape_search_term(value)
              end
            end
          end

          search_class
        end
      end
    end
  end
end

