module Mipala::Parser
  # Converts a list of symbol locations into Token structs.
  class Tokenizer
    include Mipala::Mixins::Contracts

    attr_reader :text, :symbol_locations

    def initialize(text, symbol_locations)
      @text = is_a! text, 'text', String
      @symbol_locations = is_array! symbol_locations, 'symbol_locations',
        SymbolLocator::LocatedSymbol
    end

    # Given a text index, returns a boolean indicating whether there is a symbol
    # at that index.
    def is_symbol?(index)
      symbol_locations.any? do |sym_loc|
        sym_loc.location.character_index(text) == index
      end
    end

    # Given an array of tokens, returns a copy without any empty text tokens.
    def reject_empty_text(arr)
      arr.reject { |x| x.type == :text && x.value == "" }
    end

    # Returns an array of Token objects for this text and symbol locations.
    def tokenize
      # This is implemented by splitting the text on symbols and inserting
      # tokens on the splits

      # Slice each character if there's a symbol there; this leaves the symbol
      # at the end of the character array
      # Get text characters as array with index
      chars_with_index = text.chars.each_with_index

      # Slice on symbols into 2D array of chars and indeces
      sliced_chars_with_index = chars_with_index.slice_when do |(_, i)|
        is_symbol? i
      end
      
      # Remove indexes and join nested arrays into strings
      sliced_strings = sliced_chars_with_index.map do |str_with_index|
        str_with_index.map(&:first).join
      end

      # Convert the final character of each string into a :symbol token, and
      # the rest into a :text token
      tokens = sliced_strings.zip(symbol_locations).flat_map do |text, sym_loc|
        if sym_loc.nil?
          # If the document doesn't end with a symbol, just return text
          Token.new(:text, text) 
        else
          # If it does, return both text minus symbol, and then a symbol token
          [
            Token.new(:text, text[0...-1]),
            Token.new(:symbol, sym_loc.symbol)
          ]
        end
      end

      # Strip any empty tokens (can occur when symbols are adjacent)
      tokens_without_empty = reject_empty_text(tokens)

      # Add a :nil token to the beginning to make each_cons work properly
      tokens_without_empty.unshift(Token.new(:nil, nil))

      # Convert spaces at the beginning of lines to :space_count tokens
      tokens_without_empty.each_cons(2).flat_map do |token1, token2|
        # We're only looking for :text tokens with :newline tokens before them
        next token2 unless token1 == Token.new(:symbol, :newline) \
          && token2.type == :text

        # Count the number of spaces at the beginning of the string
        spaces_at_start = token2.value.scan(/^ */).first.length

        # Return a space count and a text token
        [
          Token.new(:space_count, spaces_at_start),
          Token.new(:text, token2.value.gsub(/^ +/, ''))
        ]
      end
    end
  end
end