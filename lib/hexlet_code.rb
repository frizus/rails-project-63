# frozen_string_literal: true

require_relative "hexlet_code/version"
require "cgi"

# Генератор форм
module HexletCode
  class Error < StandardError; end
  # Your code goes here...

  def self.form_for(user, options = {}, &block)
    builder = Builder.new user, options
    block.call builder if block_given?
    builder.build
  end

  autoload(:Builder, "hexlet_code/builder.rb")
  autoload(:Tag, "hexlet_code/tag.rb")
end
