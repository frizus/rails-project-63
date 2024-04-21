# frozen_string_literal: true

module HexletCode
  module Renderers
    # Путь до вьюхов для шаблонизаторов, наследующих этот класс
    class DefaultRender
      VIEWS_PATH = File.expand_path('../views/', __dir__)
    end
  end
end
