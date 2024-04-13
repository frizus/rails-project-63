# frozen_string_literal: true

module HexletCode
  class Tag
    class << self
      @@single_tag = ['img', 'input', 'br']

      def build(tag, options = {}, &block)
        html = "<#{tag}"
        is_single_tag = single_tag?(tag)
        options.each do |key, value|
          # https://stackoverflow.com/a/3831188
          html += " #{key}=\"#{CGI::escapeHTML(value)}\""
        end
        html += ">"

        if not is_single_tag
          if block_given?
            html += yield
          end

          html += "</#{tag}>"
        end

        html
      end

      def single_tag?(tag)
        @@single_tag.include? tag.downcase
      end
    end
  end
end
