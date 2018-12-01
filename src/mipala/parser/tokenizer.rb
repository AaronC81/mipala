module Mipala::Parser
  # Converts a list of symbol locations into Token structs.
  class Tokenizer
    include Mipala::Mixins::Contracts

    Token = Struct.new 'Token', :type, :value

    attr_reader :text, :symbol_locations

    def initialize(text, symbol_locations)
      @text = is_a! text, 'text', String
      @symbol_locations = is_array! symbol_locations, 'symbol_locations',
        SymbolLocator::LocatedSymbol
    end

    # Returns an array of Token objects for this text and symbol locations.
    def tokenize
      # This is implemented by splitting the text on symbols and inserting
      # tokens on the splits

      # TODO: !!!HANDLE SPACES AT BEGINNING OF LINES!!!
      # TODO: This code is almost illegible

      # Slice each character if there's a symbol there; this leaves the symbol
      # at the end of the character array
      # TODO: This is O(n^2), not great
      sliced_text = text.chars.each_with_index.slice_when do |(char, i)|
        # Slice if this character is a symbol
        symbol_locations.any? do |sym_loc|
          (sym_loc.location.character_index text) == i
        end
      end.map { |str_with_index| str_with_index.map { |str, i| str }.join }

      # Convert this list of strings into tokens and return it
      symbol_pointer = 0
      sliced_text.flat_map do |string|
        text_token = Token.new :text, string[0..-2] # remove last char
        symbol_token = Token.new :symbol,
          symbol_locations[symbol_pointer].symbol

        symbol_pointer += 1
        [text_token, symbol_token]
      end
    end
  end
end