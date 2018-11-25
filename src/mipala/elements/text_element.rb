require 'mipala/elements/element'

module Mipala::Elements
  # An element which may contain other elements.
  class TextElement < Element
    attr_accessor :text

    def initialize definition_location, text
      super definition_location, []

      @text = text
    end

    def generate_html
      "<span>#{text}</span>"
    end
  end
end