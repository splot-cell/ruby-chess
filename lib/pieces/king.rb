# frozen_string_literal: true

require_relative "../piece"

class King < SteppingPiece
  def self.type
    KING
  end

  def move_translations
    [[-1, -1],
     [-1, 0],
     [-1, 1],
     [0, 1],
     [1, 1],
     [1, 0],
     [1, -1],
     [0, -1]]
  end

  def attack_translations
    move_translations
  end
end

Piece.register(King)
