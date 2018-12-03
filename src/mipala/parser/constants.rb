module Mipala::Parser
  module Constants
    SYMBOLS = {
      comma: ',',
      lparen: '(',
      rparen: ')',
      dot: '.',
      backslash: '\\',
      colon: ':',
      newline: "\n"
    }.freeze

    TOKEN_KINDS = [
      :text,
      :symbol,
      :space_count,
      :indent,
      :dedent,
      :nil
    ].freeze
  end
end