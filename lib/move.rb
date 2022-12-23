# frozen_string_literal: true

require_relative "constants"
require_relative "pieces/pawn"
require_relative "pieces/knight"
require_relative "pieces/bishop"
require_relative "pieces/rook"
require_relative "pieces/queen"
require_relative "pieces/king"

class Move
  include PieceType

  attr_accessor :piece, :translation_list, :promotion, :pawn_double_push, :promotion_value

  def initialize(piece, translation_list, board, promotion_value = QUEEN)
    @piece = piece
    @translation_list = translation_list
    @promotion_value = promotion_value

    @promotion = false
    @pawn_double_push = false

    pawn_flags(board) if piece.type == PAWN
  end

  def pawn_flags(board)
    # if the target square is the promotion rank of @piece
    @promotion = true if translation_list[0][1][1] == board.promotion_rank(piece.color)
    # if the difference in rank is 2
    @pawn_double_push = true if (translation_list[0][0][0] - translation_list[0][1][0]).abs == 2
  end

  def update_board_state(board)
    # TO DO
    # Update clocks here

    # If the move is a pawn_double_push, set the board's en_passant_target,
    # otherwise, set it to nil
    board.en_passant_target = pawn_double_push ? en_passant_target : nil

    # If a king or rook moves, remove the relevant castling flag from board
    board.remove_castling_avail(self) if piece.type == KING || piece.type == ROOK

    board.toggle_current_player
  end

  # calls board.translate_squares(@translation_list)
  def execute(board)
    update_board_state(board)

    board.translate_squares(translation_list)

    # if @promotion, call board.replace_piece with promotion_target
  end

  def valid?(board)
    # Store the current board position
    current_state = board.encode_fen_position
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
    translation_list[0][0].reduce { |av, v| [(av[0] + v[0]) / 2, (av[1] + v[1]) / 2] }
  end

  # Creates a piece to replace the piece being promoted
  def promotion_target(value)
    Piece.create(value, @piece.color, translation_list[0][1])
  end
end
