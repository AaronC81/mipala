require "mipala/elements/container_element"

module Mipala::Elements
  # A section of a document, with a title, containing other elements.
  class SectionElement < ContainerElement
    attr_accessor :name

    def initialize(definition_location, children, name)
      super(definition_location, children)

      @name = name
    end
  end
end