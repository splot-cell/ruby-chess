# frozen_string_literal: true

require_relative "piece"
require_relative "fen"

class Board
  include FEN

  def initialize(piece_class = Piece)
    @data = Array.new(8) { Array.new(8, piece_class.new) }
  end

  def restore_position(fen_str)
    position = position_hash(fen_str)
    @data = piece_data_from(position[:piece_placement_data])
  end

  def within_bounds?(rank_index, file_index)
    rank_index.between?(0, 7) && file_index.between?(0, 7)
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
