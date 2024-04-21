# frozen_string_literal: true

module HexletCode
  # Объект для передачи в блок метода form_for для создания полей формы через блок
  class Builder
    AS_ALIASES = { Text: 'Textarea', Input: 'InputText' }.freeze

    def initialize(form_object, form_options = {})
      @form_object = form_object
      @form_options = form_options
      @inputs = []
    end

    def build
      Form::Form.new(@form_options).render do
        @inputs.reduce('') do |acc, input|
          field_inst = resolve_field_class(input[:as]).constantize.new(
            input[:options],
            **input.slice(:no_label, :name, :value)
          )
          "#{acc}#{field_inst.render}"
        end
      end
    end

    def resolve_field_class(as)
      as = as.to_s.camelize
      as = AS_ALIASES[as.to_sym] if AS_ALIASES.key? as.to_sym
      "HexletCode::Form::Fields::#{as}Field"
    end

    def field(as, options = {}, no_label: false, name: nil, value: nil)
      @inputs << { as:, no_label:, name:, value:, options: }
    end

    def input(name, options = {})
      field(
        options.fetch(:as, :input),
        options.except(:as, :no_label),
        no_label: options.fetch(:no_label, false),
        name:,
        value: @form_object.public_send(name)
      )
    end

    def submit(value = nil)
      field(:submit, value:)
    end
  end
end
