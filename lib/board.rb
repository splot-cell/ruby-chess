# frozen_string_literal: true

require_relative "piece"

class Board

  def initialize(position = nil, piece_class = Piece)
    @data = position.nil? ? Array.new(64, piece_class.new) : position
  end

  def restore_position(fen_str)
    pos = fen_str.split
    piece_placement = pos[0]
    active_color = pos[1]
    castling = pos[2]
    en_passant = pos[3]
    half_move_clk = pos[4]
    full_move_num = pos[5]
    place_pieces(piece_placement)
  end

  def place_pieces(str)
    @data.clear
    str.split("").each do |char|
      if char =~ /[kqrbnp]/i
        color = char.match?(/[A-Z]/) ? PieceColor::WHITE : PieceColor::BLACK
        @data << Piece.create(Piece.char_to_type(char), color)
      elsif char =~ /[0-8]/
        char.to_i.times { @data << Piece.create }
      end
    end
  end

end
