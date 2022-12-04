# frozen_string_literal: true

class Move

  attr_accessor :en_passant, :castle, :promotion, :translation_list

# checks whether it's a basic or complex move...
  def basic?
    en_passant || castle || promotion
  end

# calls board.translate_squares(@translation_list)
  def execute(board)
    board.translate_squares(translation_list)
  end

# checks whether move is valid on board
  # check if en passant valid if necessary
  # check if castling valid if necessary
  # create version of board with new position and query in_check
  def valid?(board)
    return false if en_passant && board.en_passant_target != translation_list[0][1]

    return false if castle && board.castling_valid?(translation_list[1][0])

    current_state = board.encode_fen_position
    self.execute(board)
    ret = board.in_check?(board.current_player)
    board.restore_position(current_state)

    ret
  end

end
