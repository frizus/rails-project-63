# frozen_string_literal: true

require "slim"

module HexletCode
  module Renderers
    # Шаблонизатор slim
    class SlimRender < DefaultRender
      # @see https://stackoverflow.com/questions/7058993/specifying-a-layout-and-a-template-in-a-standalone-not-rails-ruby-app-using-s
      def self.render(template, variables = {}, contents = nil)
        slim_template = Slim::Template.new File.expand_path(resolve_template_path(template), VIEWS_PATH)
        if contents.nil?
          slim_template.render(nil, variables)
        else
          slim_template.render(nil, variables) { contents }
        end
      end

      def self.resolve_template_path(template)
        template = template.to_s
        if template.end_with? ".html"
          template += ".slim"
        elsif !template.end_with?(".html.slim")
          template += ".html.slim"
        end
        template
      end
      private_class_method :resolve_template_path
    end
  end
end
