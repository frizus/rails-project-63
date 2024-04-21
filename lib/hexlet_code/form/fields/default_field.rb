# frozen_string_literal: true

module HexletCode
  module Form
    module Fields
      # Базовый класс поля
      class DefaultField
        include HexletCode::Form::FormElementMixin

        attr_accessor :name, :value, :no_label

        def initialize(attributes = {}, name: nil, value: nil, no_label: false)
          @name = name
          @no_label = no_label
          @value, @attributes = merge_with_default(value, attributes)
        end

        def view_variables
          super.merge({ no_label:, name:, value: })
        end

        def render
          renderer.render(view_name, view_variables)
        end
      end
    end
  end
end
