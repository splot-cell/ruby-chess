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
    place_pieces(position[:piece_placement_data])
  end

  def place_pieces(fen_str)
    @data.clear
    fen_str.split("/").each do |r|
      rank = []
      r.split("").each do |char|
        if empty_square?(char)
          char.to_i.times { rank << Piece.create }
        else
          rank << Piece.create(piece_type_from(char), piece_color_from(char))
        end
      end
      @data << rank
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
