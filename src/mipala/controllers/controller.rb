module Mipala::Controllers
  # Represents a controller.
  # A controller walks an element tree, populating public properties required
  # to render the tree.
  class Controller
    def initialize
      @dirty = false
      @handlers = {}
    end

    def dirty?
      @dirty
    end

    # Invokes this controller on a document.
    # This simply calls #visit and sets a "dirty" flag. This method cannot be
    # called if this flag is set on the instance.
    def process doc
      raise 'Cannot re-use a Controller' if dirty?

      @dirty = true
      
      doc.visit do |element|
        @handlers.each do |k, v|
          v.(element) if element.is_a? k
        end
      end
    end

    # For use with Controller subclasses. Registers a visit handler.
    def on type, &block
      @handlers[type] = block
    end
  end
end