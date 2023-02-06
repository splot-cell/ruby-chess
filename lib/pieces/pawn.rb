# frozen_string_literal: true

require_relative "../piece"

class Pawn < SteppingPiece
  def self.type
    PAWN
  end

  def move_translations
    white = [[-1, 0]]

    return white if color == WHITE

    [[1, 0]]
  end

  def starting_rank
    return 6 if color == WHITE

    1
  end

  def attack_translations
    return [[-1, -1], [-1, 1]] if color == WHITE

    [[1, -1], [1, 1]]
  end

  def accessible_squares(translation_list, board)
    arr = []
    step_limit = @position[0] == starting_rank ? 2 : 1
    translation_list.each do |t|
      1.upto(step_limit) do |scale|
        current_sq = translated_position(scale_translation(scale, t))
        arr << current_sq if board.within_bounds?(current_sq)

        break unless board.within_bounds?(current_sq) && board.square_empty?(current_sq)
      end
    end
    arr
  end

  def threatened_squares(board)
    attack_translations.map { |t| translated_position(t) }.keep_if { |p| board.within_bounds?(p) }
  end

  def possible_move_squares(board)
    valid_moves = accessible_squares(move_translations, board).keep_if { |sq| board.square_empty?(sq) }

    valid_attacks = threatened_squares(board).keep_if do |sq|
      board.color_at_sq(sq) == board.opponent_color(@color) ||
        board.en_passant_target == sq
    end

    valid_moves + valid_attacks
  end
end

Piece.register(Pawn)
