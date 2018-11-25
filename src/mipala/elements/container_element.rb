require "mipala/elements/element"

module Mipala::Elements
  # An element which may contain other elements.
  class ContainerElement < Element
    attr_accessor :children

    def initialize definition_location, children
      super definition_location

      @children = children
    end

    def generate_html
      children_as_html = children.map &:generate_html
      children_as_html.inject :+
    end

    def visit &block
      super &block
      children.each { |x| x.visit &block }
    end
  end
end