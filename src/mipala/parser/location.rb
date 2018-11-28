module Mipala::Parser
  # A particular location in a file.
  class Location
    attr_reader :file, :row, :column

    def initialize file, row, column
      @file = file
      @row = row
      @column = column
    end

    # A "null" location.
    def self.anonymous
      Location.new '<anonymous>', -1, -1
    end
  end
end