# frozen_string_literal: true

require_relative "constants"

class Move
  include PieceType

  attr_accessor :en_passant, :castle, :promotion, :translation_list, :pawn_double_push, :piece

  # checks whether it's a basic or complex move...
  def basic?
    !(en_passant || castle || promotion)
  end

  # update half move clk if necessary
  # update full move num if necessary
  # update en passant target if necessary
  # update castlign if necessary
  # call toggle_current_player
  def update_board_state(board)
    board.en_passant_target = pawn_double_push ? self.en_passant_target : nil

    board.remove_castling_avail(self) if piece.type == KING || piece.type == ROOK

    board.toggle_current_player
  end

  # calls board.translate_squares(@translation_list)
  def execute(board)
    update_board_state(board)

    board.translate_squares(translation_list)
  end

  # checks whether move is valid on board
  # check if en passant valid if necessary
  # check if castling valid if necessary
  # create version of board with new position and query in_check
  def valid?(board)
    # if this is an en passant move, check that the square under attack is the en passant square
    return false if en_passant && board.en_passant_target != translation_list[0][1]

    return false if castle && board.castling_valid?(translation_list[1][0])

    current_state = board.encode_fen_position
    self.execute(board)
    ret = board.in_check?(board.current_player)
    board.restore_position(current_state)

    ret
  end

  def en_passant_target
    translation_list[0].reduce { |av, v| [(av[0] + v[0]) / 2, (av[1] + v[1]) / 2] }
  end

end
