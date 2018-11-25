require "mipala/elements/container_element"

module Mipala::Elements
  # A section of a document, with a title, containing other elements.
  class SectionElement < ContainerElement
    attr_accessor :name

    def initialize definition_location, children, name
      super definition_location, children, [:number]

      @name = name
    end

    def generate_html
      # TODO: Multilevel sections
      "<h1>#{render_fields[:number]} - #{@name}</h1>" + super
    end
  end
end