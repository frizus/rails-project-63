# frozen_string_literal: true

module HexletCode
  # Генератор тегов
  class Tag
    @single_tag = %w[img input br]

    class << self
      def build(tag, options = {})
        # https://stackoverflow.com/a/3831188
        html = "<#{tag}#{options.reduce("") { |acc, (k, v)| acc + " #{k}=\"#{CGI.escapeHTML(v)}\"" }}>"
        unless single_tag?(tag)
          html += yield if block_given?
          html += "</#{tag}>"
        end
        html
      end

      private

      def single_tag?(tag)
        instance_variable_get(:@single_tag).include? tag.downcase
      end
    end
  end
end
