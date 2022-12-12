# frozen_string_literal: true

require_relative "../piece"

class Queen < SlidingPiece
  def self.type
    QUEEN
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

Piece.register(Queen)
