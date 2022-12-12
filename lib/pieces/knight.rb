# frozen_string_literal: true

require_relative "../piece"

class Knight < SteppingPiece
  def self.type
    KNIGHT
  end

  def move_translations
    [[1, 2],
     [-1, 2],
     [1, -2],
     [-1, -2],
     [2, 1],
     [2, -1],
     [-2, 1],
     [-2, -1]]
  end

  def attack_translations
    move_translations
  end
end

Piece.register(Knight)
