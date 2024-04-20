# frozen_string_literal: true

module HexletCode
  # Объект для передачи в блок form_for для прописывания создания полей в блоке
  class Builder
    def initialize(form_object, form_options = {})
      @form_object = form_object
      @form_options = normalize_form_options(form_options)
      @inputs = []
    end

    def normalize_form_options(form_options)
      form_options[:action] = form_options.delete(:url) if form_options.key?(:url)
      form_options[:action] ||= "#"
      form_options[:method] ||= "post"
      form_options
    end

    def build
      Tag.build("form", @form_options) do
        result = ""
        result += "\n" unless @inputs.empty?

        result += @inputs.reduce("") do |acc, input|
          "#{acc}    #{Tag.public_send("build_#{input[:as]}", input[:name], input[:value], input[:options])}\n"
        end
        result
      end
    end

    def input(name, options = {})
      return unless @form_object.respond_to? name

      @inputs << {
        name: name.to_s,
        value: @form_object.public_send(name),
        as: options.fetch(:as, :input),
        options: options.except(:as)
      }
    end
  end
end
