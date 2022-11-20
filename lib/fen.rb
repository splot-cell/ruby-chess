# frozen_string_literal: true

require_relative "piece.rb"

module FEN
  def piece_type_from(char)
    {
      "k" => PieceType::KING,
      "q" => PieceType::QUEEN,
      "r" => PieceType::ROOK,
      "b" => PieceType::BISHOP,
      "n" => PieceType::KNIGHT,
      "p" => PieceType::PAWN
    }[char.downcase]
  end

  def piece_color_from(char)
    char.match?(/[A-Z]/) ? PieceColor::WHITE : PieceColor::BLACK
  end

  def position_hash(pos_str)
    pos_arr = pos_str.split
    {
      piece_placement_data: pos_arr[0],
      active_color: pos_arr[1],
      castling_avail: pos_arr[2],
      en_passant_target: pos_arr[3],
      half_move_clk: pos_arr[4],
      full_move_num: pos_arr[5]
    }
  end

  def empty_square?(char)
    char.match?(/[1-8]/)
  end

  def next_rank
    "/"
  end
end
