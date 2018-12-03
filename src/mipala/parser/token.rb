module Mipala::Parser
  # A Token produced by a tokenizer.
  class Token
    include Mipala::Mixins::Contracts

    attr_reader :type, :value

    def initialize(type, value)
      @type = is_a! type, 'type', Symbol

      raise 'invalid type' unless Constants::TOKEN_KINDS.include? type

      @value = value
    end

    def inspect
      to_s
    end

    def ==(other)
      other.is_a?(Token) && other.type == type && other.value == value
    end

    def hash
      type.hash + value.hash
    end

    def to_s
      return ">" if type == :indent
      return "<" if type == :dedent

      prefix = case type
      when :text
        "@"
      when :symbol
        "."
      when :space_count
        "!"
      else
        "???"
      end

      "#{prefix}#{value.inspect}"
    end
  end
end