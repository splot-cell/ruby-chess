# frozen_string_literal: true

require_relative "constants"
require_relative "pieces/pawn"
require_relative "pieces/knight"
require_relative "pieces/bishop"
require_relative "pieces/rook"
require_relative "pieces/queen"
require_relative "pieces/king"

# Contains data needed to validate and execute a move
class Move
  include PieceType

  attr_accessor :piece, :translation_list, :promotion, :pawn_double_push

  def initialize(piece, target_square, board, promotion_value = QUEEN)
    @piece = piece
    @target_square = target_square
    @translation_list = create_translation_list(target_square)
    @promotion_value = promotion_value

    @promotion = false
    @pawn_double_push = false

    @board = board

    pawn_flags(board) if piece.type == PAWN
  end

  def create_translation_list(target_sq)
    # Check if the piece is a king moving left/right by two squares
    return [[piece.position, target_sq]] unless piece.type == KING && (piece.position[1] - target_sq[1]).abs == 2

    # If so, create a castling-specific translation_list
    create_castling_translation_list(target_sq)
  end

  def create_castling_translation_list(target_sq)
    rank = target_sq[0]

    if target_sq[1] == 6
      [[piece.position, target_sq], [[rank, 7], [rank, 5]]]
    else
      [[piece.position, target_sq], [[rank, 0], [rank, 3]]]
    end
  end

  def pawn_flags(board = @board)
    # if the target square is the promotion rank of @piece
    @promotion = true if translation_list[0][1][0] == board.promotion_rank(piece.color)
    # if the difference in rank is 2
    @pawn_double_push = true if (translation_list[0][0][0] - translation_list[0][1][0]).abs == 2
  end

  def half_move_clk_update?
    return true if @board.square_empty?(@target_square) && piece.type != PAWN

    @board.reset_half_clk
    false
  end

  def update_board_state(board = @board)
    board.update_half_move_clk if half_move_clk_update?
    board.update_full_move_num if piece.color == Color::BLACK
    board.clear_move_pool

    # If the move is a pawn_double_push, set the board's en_passant_target,
    # otherwise, set it to nil
    board.en_passant_target = pawn_double_push ? en_passant_target : nil

    # If a king or rook moves, remove the relevant castling flag from board
    board.remove_castling_avail(self) if piece.type == KING || piece.type == ROOK

    board.toggle_current_player
  end

  # calls board.translate_squares(@translation_list)
  def execute(board = @board)
    update_board_state(board)

    board.translate_squares(translation_list)

    # if @promotion, call board.replace_piece with promotion_target
    board.replace_piece(translation_list[0][1], promotion_target) if @promotion
  end

  def valid?(board = @board)
    # Store the current board position
    current_state = board.encode_game_state
    # Execute the proposed move
    board.translate_squares(translation_list)
    # Check whether the player is in check after the proposed move:
    # if so, the move is not valid
    ret = !board.in_check?(board.current_player)
    # Restore the board position
    board.restore_position(current_state)
    # Return the result of the validity check
    ret
  end

  # Finds the square between the start square and finish square for the first
  # translation. For use with a pawn_double_push move
  def en_passant_target
    start_i = translation_list[0][0][0]
    end_i = translation_list[0][1][0]
    [(start_i + end_i) / 2, translation_list[0][0][1]]
  end

  # Creates a piece to replace the piece being promoted
  def promotion_target
    Piece.create(@promotion_value, piece.color, translation_list[0][1])
  end
end
