module Mipala::Parser
  # A particular location in a file.
  class Location
    include Mipala::Mixins::Contracts

    attr_reader :file, :row, :column

    def initialize file, row, column
      @file = file
      @row = row
      @column = column

      @charater_index = nil # cached
    end

    # A "null" location.
    def self.anonymous
      Location.new '<anonymous>', -1, -1
    end

    # Finds the character index of this location within a string.
    def character_index(text)
      is_a! text, 'text', String

      return @character_index unless @character_index.nil?

      curr_row = 1
      curr_col = 1

      text.chars.each.with_index do |char, i|
        # Alter location
        if char == "\n"
          curr_col = 1
          curr_row += 1
        else
          curr_col += 1
        end


        
        # Check for match
        return (@character_index = i) if curr_row == row && curr_col == column

        # Check if no longer possible to match
        raise 'no such location in given text' if curr_row > row || \
          (curr_row == row && curr_col > column)
      end

      # Raise if not returned
      raise 'no such location in given text'
    end
  end
end