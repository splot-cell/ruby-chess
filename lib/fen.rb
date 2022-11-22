# frozen_string_literal: true

require_relative "piece"
require_relative "constants"

# Module for interfacing between Forsyth-Edwards Notation (FEN) and classes

# Overview for FEN here:
# https://en.wikipedia.org/wiki/Forsyth%E2%80%93Edwards_Notation

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
    char.match?(/[A-Z]/) ? Color::WHITE : Color::BLACK
  end

  def fen_char_from(piece)
    {
    Color::BLACK => {
      PieceType::KING => "k",
      PieceType::QUEEN => "q",
      PieceType::ROOK => "r",
      PieceType::BISHOP => "b",
      PieceType::KNIGHT => "n",
      PieceType::PAWN => "p"
    },
    Color::WHITE => {
      PieceType::KING => "K",
      PieceType::QUEEN => "Q",
      PieceType::ROOK => "R",
      PieceType::BISHOP => "B",
      PieceType::KNIGHT => "N",
      PieceType::PAWN => "P"
    }
    }[piece.color][piece.type]
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

  def piece_data_from(fen_str)
    temp_data = []
    fen_str.split("/").each do |r|
      rank = []
      r.split("").each do |char|
        if empty_square?(char)
          char.to_i.times { rank << Piece.create }
        else
          rank << Piece.create(piece_type_from(char), piece_color_from(char))
        end
      end
      temp_data << rank
    end
    temp_data
  end

  def pos_to_fen
    fen = ""
    @data.each do |r|
      empty_count = 0
      r.each do |piece|
        if piece.type == PieceType::NONE
          empty_count += 1
        else
          fen += empty_count.to_s unless empty_count == 0
          empty_count = 0
          fen += fen_char_from(piece)
        end
      end
      fen += empty_count.to_s unless empty_count == 0
      fen += "/" unless r == @data.last
    end
    fen
  end
end
