# frozen_string_literal: true

module HexletCode
  module Form
    # <form>
    class Form
      include FormElementMixin

      def initialize(attributes = {})
        @attributes = merge_with_default(attributes)
      end

      def merge_with_default(attributes)
        attributes[:action] = attributes.delete(:url) if attributes.key?(:url)
        attributes[:action] ||= '#'
        attributes[:method] ||= 'post'
        attributes
      end

      def render(inner_html = nil)
        inner_html = yield if inner_html.nil? && block_given?
        renderer.render(view_name, view_variables, inner_html)
      end
    end
  end
end
