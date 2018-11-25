module Mipala::Elements
  # Represents an element of a document.
  class Element
    attr_reader :definition_location

    def initialize definition_location 
      @definition_location = definition_location
    end

    def generate_html
      raise 'You must override Element#generate_html'
    end

    def visit &block
      yield_self &block
    end
  end
end