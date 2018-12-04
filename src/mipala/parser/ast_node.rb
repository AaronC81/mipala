module Mipala::Parser
  # Represents a node of the parse AST.
  class ASTNode
    include Mipala::Mixins::Contracts

    def inspect
      to_s
    end

    def to_s
      to_tree_string
    end

    # Converts the node to a tree-style string representation.
    def to_tree_string(indent_level=0)
      indent = ->(s){ '  ' * indent_level + s }

      string = indent(self.class.name)

      instance_variables.each do |iv|
        value = instance_variable_get(iv)
        if value.is_a? ASTNode
          string += indent("  #{iv.to_s[1..-1]}:")
          string += indent("  #{value.to_tree_string(indent_level + 1)}")
        else
          string += indent("  #{iv.to_s[1..-1]}: #{iv}")
        end
      end
    end
  end

  # A raw text node.
  class TextNode
    attr_reader :text

    def initialize(text)
      super
      @text = is_a! text, 'text', String
    end
  end

  class CommandNode
    attr_reader :name, :parameters, :body

    def initialize(name, parameters, body)
      super
      @name = is_a! name, 'name', TextNode
      @parameters = is_an_array! parameters, 'parameters', ASTNode
      @body = is_an_array! body, 'body', ASTNode
    end
  end
end