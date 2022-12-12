# frozen_string_literal: true

require_relative "../piece"

class Rook < SlidingPiece
  def self.type
    ROOK
  end

  def move_translations
    [[-1, 0],
     [0, 1],
     [1, 0],
     [0, -1]]
  end

  def attack_translations
    move_translations
  end
end

Piece.register(Rook)
