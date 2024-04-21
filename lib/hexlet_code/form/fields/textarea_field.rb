# frozen_string_literal: true

module HexletCode
  module Form
    module Fields
      # <textarea>
      class TextareaField < DefaultField
        def initialize(attributes = {}, name: nil, value: nil, no_label: false)
          self.default_attributes = {
            cols: 20,
            rows: 40
          }
          super
        end
      end
    end
  end
end
