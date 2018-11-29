module Mipala::Parser
  # Tokenizes a string of Mipala text.
  class Tokenizer
    Token = Struct.new 'Token', :type, :contents

    attr_reader :text, :indent_size

    def initialize text 
      @text = text
      @indent_size = nil
      @pointer = 0
    end

    # Tokenizes #text into an Array of Token objects.
    def tokenize
      tokens = []
      push = Proc.new do |type, contents|
        new_token = Token.new type, contents
        tokens << new_token
      end

      current_indentation = 0 # not implemented
      mode = :text
      until done?
        puts @pointer
        # Recognise symbols
        if here == ':'
          push.call :sym_colon, here
          advance
        elsif here == ','
          push.call :sym_comma, here
          advance
        elsif here == '('
          push.call :sym_lparen, here
          advance
        elsif here == ')'
          push.call :sym_rparen, here
          advance
          mode = :text
        # Handle escapes
        elsif here == '\\'
          push.call :sym_backslash, here
          advance
          mode = :command
        # Handle command identifiers
        elsif mode == :command
          # Take characters until we hit an escape \
          buffer = here
          advance
          buffer += take_while do |x|
            (("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a).include? x
          end.join
          push.call :identifier, buffer
        # Handle raw text
        else
          # Take characters until we hit an escape \
          buffer = here
          advance
          # TODO: Deal with turning newlines into spaces, and eliminating
          # duplicate spaces, in a later stage
          buffer += take_until { |x| x == '\\' }.join
          push.call :text, buffer
        end
      end

      tokens
    end

    # Returns a boolean indicating whether the end of the text has been reached.
    def done?
      @pointer >= text.length
    end

    # Returns the indent size required as a string, e.g. "2 spaces".
    def indent_size_string
      "#{indent_size} space#{indent_size == 1 ? '' : 's'}"
    end

    protected

    # Returns the text character currently being pointed to.
    def here
      text[@pointer]
    end

    # Increments the pointer by a certain number of places. If passed a string,
    # increments by the length of the string. Returns the amount advanced by.
    # If no argument is given, advance by 1.
    def advance amount=1
      amount = amount.length if amount.is_a? String
      @pointer += amount
      amount
    end

    # Collects characters and advances the pointer while the block returns
    # true. The block is passed the current character. Returns the collected
    # characters.
    def take_while &block
      chars = []
      while (block.call here) && !done?
        chars << here
        advance
      end
      chars
    end

    # Collects characters and advances the pointer while the block returns
    # false. The block is passed the current character. Returns the collected
    # characters.
    def take_until &block
      take_while do |*args|
        !block.call *args
      end
    end
  end
end