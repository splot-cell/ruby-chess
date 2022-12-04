# frozen_string_literal: true

require_relative "piece"
require_relative "fen"

class Board
  include FEN

  attr_reader :en_passant_target, :current_player

  def initialize(data = Array.new(8) { Array.new(8) })
    @data = data
    @current_player = Color::WHITE
    @castling_avail = "KQkq"
    @en_passant_target = nil
    @half_move_clk = 0
    @full_move_num = 1
  end

  def restore_position(fen_str)
    position = decode_game_state(fen_str)
    @data = position[:piece_placement_data]
    @current_player = position[:active_color]
    @castling_avail = position[:castling_avail]
    @en_passant_target = position[:en_passant_target]
    @half_move_clk = position[:half_move_clk]
    @full_move_num = position[:full_move_num]
  end

  def within_bounds?(rank_index, file_index)
    rank_index.between?(0, 7) && file_index.between?(0, 7)
  end

  # castling_valid?(rook_square)
  # checks if squares between rook and king are free
  # checks if castling_avail

  # game_over?
  # after generating move pool, there are zero valid moves
  # if one color is in check -> mate
  # if not -> stalemate

  # update_state(move)
  # checks move.valid?(self)
  # update half move clk if necessary
  # update full move num if necessary
  # update en passant target if necessary
  # update castlign if necessary
  # call toggle_current_player

  # sq under attack?(sq, color)
  # checks if any of the pieces of color are attacking sq

  # in_check?(color)
  # checks if the King of color is under attack?

  # generate move_pool(color)
  # for each piece, try all its direction vectors and add move to pool
  # if pawn, also try attacking direction vectors
  # depending on castling state, check to see if castling squares are open, if so, add move to move pool
  # validate each move in move pool does not leave you in check

  def translate_squares(translations)
    translations.each do |translation|
      starting_pos = translation[0]
      ending_pos = translation[1]
      @data[ending_pos[0]][ending_pos[1]] = @data[starting_pos[0]][starting_pos[1]]
      @data[starting_pos[0]][starting_pos[1]] = nil
    end
  end

  def to_s
    str = ""
    8.times do |rank|
      str += (8 - rank).to_s
      8.times do |file|
        cell = rank * 8 + file
        color = (rank + file).even ? "\e[40m" : ""
        piece = @data[cell]
        piece_str = piece ? piece.to_s : " "
        str += "#{color} #{piece_str} \e[0m"
      end
      str += "\n"
    end
    str += "  a  b  c  d  e  f  g  h"
    str
  end
end
