module Mipala::Parser
  module Constants
    SYMBOLS = {
      comma: ',',
      lparen: '(',
      rparen: ')',
      dot: '.',
      backslash: '\\'
    }.freeze

    TOKEN_KINDS = [
      :text,
      :symbol,
      :space_count
    ]
  end
end