# frozen_string_literal: true

require_relative "../piece"

class Pawn < SteppingPiece
  def self.type
    PAWN
  end

  def move_translations
    white = [[-1, 0]]
    white << [-2, 0] if @position[0] == 6

    return white if color == WHITE

    return [[1, 0], [2, 0]] if @position[0] == 1

    [[1, 0]]
  end

  def attack_translations
    return [[-1, -1], [-1, 1]] if color == WHITE

    [[1, -1], [1, 1]]
  end
end

Piece.register(Pawn)
