# frozen_string_literal: true

class Move

# @en_passant
# @castle
# @promotion
# @translation_list

# #basic?
# checks whether it's a basic or complex move...

# execute(board)
# calls board.translate_squares(@translation_list)

# valid?(board)
# checks whether move is valid on board
  # check if en passant if necessary
  # check if castling if necessary
  # create version of board with new position and query in_check

end
