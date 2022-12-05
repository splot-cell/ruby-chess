# frozen_string_literal: true

require_relative "../piece"

class King < Piece
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

  def sliding?
    false
  end
end

Piece.register(King)
