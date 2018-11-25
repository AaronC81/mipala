module Mipala::Elements
  # Represents an element of a document.
  class Element
    attr_reader :definition_location, :render_fields

    PENDING = :pending

    def initialize definition_location, render_field_keys
      @definition_location = definition_location

      @render_fields = {}
      render_field_keys.each do |k|
        render_fields[k] = PENDING
      end
    end

    def generate_html
      raise 'You must override Element#generate_html'
    end

    def visit &block
      yield_self &block
    end
  end
end