# frozen_string_literal: true

require_relative "piece"
require_relative "fen"

class Board
  include FEN

  def initialize(position = nil, piece_class = Piece)
    @data = position.nil? ? Array.new(64, piece_class.new) : position
  end

  def restore_position(fen_str)
    position = position_hash(fen_str)
    place_pieces(position[:piece_placement_data])
  end

  def place_pieces(fen_str)
    @data.clear
    fen_str.split("").each do |char|
      next if char == next_rank

      if empty_square?(char)
        char.to_i.times { @data << Piece.create }
      else
        @data << Piece.create(piece_type_from(char), piece_color_from(char))
      end
    end
  end
end
