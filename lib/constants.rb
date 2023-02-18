# frozen_string_literal: true

module PieceType
  KING = 0
  QUEEN = 1
  ROOK = 2
  BISHOP = 3
  KNIGHT = 4
  PAWN = 5
end

module Color
  WHITE = 0
  BLACK = 6

  def player_string(player)
    {
      0 => "WHITE",
      6 => "BLACK"
    }[player]
  end
end
