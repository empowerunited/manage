module Manage
  module ApplicationHelper

    def collection_table collection, resource_class, no_items_text

      if collection.empty?
        return content_tag(:h3, resource_class.model_name.human(count: 2)) + content_tag(:p,  no_items_text)
      else
        rows = []

        ths = resource_class.attribute_names.collect do |attr|
          content_tag(:td, truncate(resource_class.human_attribute_name(attr).to_s, length: 50))
        end.join('').html_safe
        rows << content_tag(:tr, ths)

        collection.each do |item|
          tds = resource_class.attribute_names.collect do |attr|
            content_tag(:td, truncate(item.public_send(attr).to_s, length: 50))
          end.join('').html_safe

          rows << content_tag(:tr, tds)
        end
        content_tag(:h3, resource_class.model_name.human(count: 2)) +
        content_tag(:table, rows.join('').html_safe)
      end
    end

    def condensed_table resource_class, cols=2
      rows = []
      resource_class.attribute_names.each_slice(cols).each do |slice|
        row = slice.collect do |attr|
          content_tag(:td, resource_class.human_attribute_name(attr)) +
          content_tag(:td, resource.public_send(attr))
        end
        rows << content_tag(:tr, row.join('').html_safe)
      end

      content_tag :table, rows.join('').html_safe
    end

  end
end
