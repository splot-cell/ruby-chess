# frozen_string_literal: true

require_relative "../piece"

class Bishop < Piece
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

  def sliding?
    true
  end
end

Piece.register(Bishop)
