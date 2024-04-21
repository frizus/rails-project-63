# frozen_string_literal: true

module HexletCode
  # Генератор тегов
  class Tag
    @single_tag = %w[img input br]

    class << self
      def build(tag, options = {})
        # https://stackoverflow.com/a/3831188
        html = "<#{tag}#{options.reduce('') { |acc, (k, v)| acc + " #{k}=\"#{CGI.escapeHTML(v.to_s)}\"" }}>"
        unless single_tag?(tag)
          html += yield if block_given?
          html += "</#{tag}>"
        end
        html
      end

      def build_input(name = nil, value = nil, options = {})
        options[:name] = name unless name.nil?
        options[:type] = 'text'
        options[:value] = value unless value.nil?

        build('input', options)
      end

      def build_textarea(name = nil, value = nil, options = {})
        options[:name] = name unless name.nil?
        options[:cols] ||= 20
        options[:rows] ||= 40

        build('textarea', options) { value }
      end
      alias build_text build_textarea

      private

      def single_tag?(tag)
        instance_variable_get(:@single_tag).include? tag.downcase
      end
    end
  end
end
