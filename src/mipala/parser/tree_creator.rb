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
    end

    protected

    # Gets the token at the pointer.
    def here
      tokens[pointer]
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
  end
end