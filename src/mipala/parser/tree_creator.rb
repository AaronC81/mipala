module Mipala::Parser
  # Given a collection of tokens, creates a parse tree of ASTNodes.
  class TreeCreator
    attr_reader :tokens, :pointer

    def initialize(tokens)
      @tokens = tokens
      @pointer = 0
    end

    def create_tree
      @pointer = 0
      # TODO: Probably need to accept many nodes; maybe implicit body parent?
      expect_node
    end

    protected

    # Creates a node, beginning from the current pointer. Throws an exception
    # if this is not possible.
    def expect_node
      
    end

    def end?
      pointer == tokens.length
    end

    # Gets the token at the pointer.
    def here
      tokens[pointer] || raise 'exhausted token stream'
    end

    # Advances the token pointer.
    def advance
      @pointer++
    end

    # Expects to find a token of a particular type at the token pointer, and
    # returns it, incrementing the pointer. Throws an exception if the token is
    # not of this type.
    def expect(type)
      raise 'unexpected token' unless here.type == type
      result = here
      advance
      result
    end

    # If the token at the pointer is of a particular type, returns it,
    # incrementing the pointer. Otherwise, returns nil.
    def accept(type)
      return nil unless here.type == type
      result = here
      advance
      result
    end

    # Accepts as many of the specified token type as possible, returning an
    # array of them. This array could be empty. The token pointer is advanced
    # to one place after this array. This will not throw an exception upon
    # reaching the end of the token stream.
    def accept_many(type)
      tokens = []
      while !end? && here.type == type
        tokens << here
        advance
      end
      tokens
    end
  end
end