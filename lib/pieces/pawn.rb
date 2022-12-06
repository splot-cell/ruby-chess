# frozen_string_literal: true

require_relative "../piece"

class Pawn < Piece
  def initialize(*)
    super
    @has_moved = false
  end

  def self.type
    PAWN
  end

  def move_translations
    white = [[-1, 0]]
    white << [-2, 0] unless @has_moved

    return white if color == WHITE

    return [[1, 0], [2, 0]] unless @has_moved

    [[1, 0]]
  end

  def attack_translations
    return [[-1, -1], [-1, 1]] if color == WHITE

    [[1, -1], [1, 1]]
  end

  def sliding?
    false
  end
end

Piece.register(Pawn)
