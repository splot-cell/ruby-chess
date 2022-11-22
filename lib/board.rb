# frozen_string_literal: true

require_relative "piece"
require_relative "fen"

class Board
  include FEN

  def initialize(piece_class = Piece)
    @data = Array.new(8) { Array.new(8, piece_class.new) }
    @current_player = Color::WHITE
    @castling_avail = "KQkq"
    @en_passant_target = nil
    @half_move_clk = 0
    @full_move_num = 1
  end

  def restore_position(fen_str)
    position = position_hash(fen_str)
    @data = piece_data_from(position[:piece_placement_data])
    @current_player = current_player_from(position[:active_color])
    @castling_avail = position[:castling_avail]
    @en_passant_target = en_passant_target_from(position[:en_passant_target])
    @half_move_clk = position[:half_move_clk].to_i
    @full_move_num = position[:full_move_num].to_i
  end

  def within_bounds?(rank_index, file_index)
    rank_index.between?(0, 7) && file_index.between?(0, 7)
  end

  def make_move(move)
    move.each do |sub_move|
      starting_pos = sub_move[0]
      ending_pos = sub_move[1]
      @data[ending_pos[0]][ending_pos[1]] = @data[starting_pos[0]][starting_pos[1]]
      @data[starting_pos[0]][starting_pos[1]] = Piece.create
    end
  end

  def to_s
    str = ""
    8.times do |rank|
      str += (8 - rank).to_s
      8.times do |file|
        cell = rank * 8 + file
        color = rank.even? ? (file.even? ? "" : "\e[40m") : (file.even? ? "\e[40m" : "")
        str += "#{color} #{@data[cell].to_s} \e[0m"
      end
      str += "\n"
    end
    str += "  a  b  c  d  e  f  g  h"
    str
  end
end
