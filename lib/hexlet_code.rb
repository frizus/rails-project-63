# frozen_string_literal: true

require_relative "hexlet_code/version"
require "cgi"

module HexletCode
  class Error < StandardError; end
  # Your code goes here...

  autoload(:Tag, "#{__dir__}/hexlet_code/tag.rb")
end
