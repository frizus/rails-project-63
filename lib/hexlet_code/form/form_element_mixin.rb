# frozen_string_literal: true

module HexletCode
  module Form
    # Миксин для атрибутов по умолчанию, значения, шаблонизатора для полей и формы
    module FormElementMixin
      def self.included(base)
        base.attr_accessor :attributes, :default_value
        base.attr_writer :use_default_attributes, :default_attributes, :renderer
      end

      def renderer
        @renderer ||= HexletCode::Renderers::SlimRender
      end

      def default_attributes
        @default_attributes ||= {}
      end

      def use_default_attributes
        @use_default_attributes = true if @use_default_attributes.nil?

        @use_default_attributes
      end

      def view_name
        self.class.name.demodulize.underscore
      end

      def view_variables
        { attributes: }
      end

      def merge_with_default(value, attributes)
        value ||= default_value
        attributes = default_attributes.merge(attributes) if use_default_attributes
        [value, attributes]
      end
    end
  end
end
