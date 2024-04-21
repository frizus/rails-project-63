# frozen_string_literal: true

require_relative "hexlet_code/version"
require "cgi"
require "active_support"
require "active_support/inflections"

# Генератор форм
module HexletCode
  class Error < StandardError; end

  def self.form_for(user, options = {}, &block)
    builder = Builder.new user, options
    block.call builder if block_given?
    builder.build
  end

  autoload(:Builder, "hexlet_code/builder.rb")
  autoload(:Tag, "hexlet_code/tag.rb")

  # Шаблонизаторы
  module Renderers
    autoload(:DefaultRender, "hexlet_code/renderers/default_render.rb")
    autoload(:SlimRender, "hexlet_code/renderers/slim_render.rb")
  end

  # Форма
  module Form
    autoload(:Form, "hexlet_code/form/form.rb")
    autoload(:FormElementMixin, "hexlet_code/form/form_element_mixin.rb")

    # Поля
    module Fields
      autoload(:DefaultField, "hexlet_code/form/fields/default_field.rb")
      autoload(:InputTextField, "hexlet_code/form/fields/input_text_field.rb")
      autoload(:TextareaField, "hexlet_code/form/fields/textarea_field.rb")
      autoload(:SubmitField, "hexlet_code/form/fields/submit_field.rb")
    end
  end
end
