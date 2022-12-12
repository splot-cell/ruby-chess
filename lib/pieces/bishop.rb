# frozen_string_literal: true

require_relative "../piece"

class Bishop < SlidingPiece
  def self.type
    BISHOP
  end

  def move_translations
    [[-1, -1],
     [-1, 1],
     [1, 1],
     [1, -1]]
  end

  def attack_translations
    move_translations
  end
end

Piece.register(Bishop)
