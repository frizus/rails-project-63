# frozen_string_literal: true

module HexletCode
  module Form
    module Fields
      # input[type=submit]
      class SubmitField < DefaultField
        def initialize(attributes = {}, name: nil, value: nil, no_label: false)
          self.default_value = "Save"
          super
        end
      end
    end
  end
end
