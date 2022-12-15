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

  def possible_move_squares(board)
    step_moves = accessible_squares(move_translations, board).keep_if do |sq|
      board.square_empty?(sq) || board.color_at_sq(sq) == board.opponent_color(@color)
    end
    step_moves.concat(possible_castling_moves(board))
  end

  def possible_castling_moves(board)
    castling_moves = []
    board.rook_starting_squares(color).each do |sq|
      castling_moves << castling_square(sq) if board.castling_valid?(sq)
    end
    castling_moves
  end

  private

  def castling_square(rook_square)
    file = rook_square[1] < position[1] ? position[1] - 2 : position[1] + 2
    [position[0], file]
  end
end

Piece.register(King)
