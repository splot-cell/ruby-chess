# frozen_string_literal: true

require_relative "piece"
require_relative "constants"
require_relative "coordinates"

# Module for interfacing between Forsyth-Edwards Notation (FEN) and classes

# Overview for FEN here:
# https://en.wikipedia.org/wiki/Forsyth%E2%80%93Edwards_Notation

module FEN
  include Coordinates

  def decode_fen_type(char)
    {
      "k" => PieceType::KING,
      "q" => PieceType::QUEEN,
      "r" => PieceType::ROOK,
      "b" => PieceType::BISHOP,
      "n" => PieceType::KNIGHT,
      "p" => PieceType::PAWN
    }[char.downcase]
  end

  def decode_fen_color(char)
    char.match?(/[A-Z]/) ? Color::WHITE : Color::BLACK
  end

  def encode_fen_piece(piece)
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

  def decode_game_state(fen_str)
    arr = fen_str.split
    {
      piece_placement_data: decode_fen_position(arr[0]),
      active_color: decode_fen_color(arr[1]),
      castling_avail: arr[2],
      en_passant_target: decode_fen_en_passant(arr[3]),
      half_move_clk: arr[4].to_i,
      full_move_num: arr[5].to_i
    }
  end

  def empty_square?(char)
    char.match?(/[1-8]/)
  end

  def next_rank
    "/"
  end

  def decode_fen_en_passant(str)
    return if str == "-"

    [num_to_rank_index(str[1]), letter_to_file_index(str[0])]
  end

  def decode_fen_position(fen_str)
    temp_data = []
    fen_str.split(next_rank).each do |r|
      rank = []
      r.split("").each do |char|
        if empty_square?(char)
          char.to_i.times { rank << nil }
        else
          rank << Piece.create(decode_fen_type(char), decode_fen_color(char))
        end
      end
      temp_data << rank
    end
    temp_data
  end

  def encode_fen_position
    fen = ""
    @data.each do |r|
      empty_count = 0
      r.each do |piece|
        if piece.nil?
          empty_count += 1
        else
          fen += empty_count.to_s unless empty_count.zero?
          empty_count = 0
          fen += encode_fen_piece(piece)
        end
      end
      fen += empty_count.to_s unless empty_count.zero?
      fen += "/" unless r.equal?(@data.last)
    end
    fen
  end
end
