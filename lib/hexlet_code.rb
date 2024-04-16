# frozen_string_literal: true

require_relative "hexlet_code/version"
require "cgi"

# Генератор форм
module HexletCode
  class Error < StandardError; end
  # Your code goes here...

  def self.form_for(user, options = {})
    options[:method] ||= "post"
    if options[:url]
      options[:action] = options[:url]
      options.delete(:url)
    end
    options[:action] ||= "#"
    options = options.sort.to_h
    Tag.build("form", options)
  end

  autoload(:Tag, "hexlet_code/tag.rb")
end
