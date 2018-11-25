module Mipala::Controllers
  # Fills in section numbers.
  class SectionController < Controller
    def initialize
      super
      @count = 1

      on Mipala::Elements::SectionElement do |el|
        el.render_fields[:number] = @count
        @count += 1
      end
    end
  end
end