# frozen_string_literal: true

require_relative "piece"
require_relative "constants"
require_relative "coordinate_translator"

# Module for interfacing between Forsyth-Edwards Notation (FEN) and classes

# Overview for FEN here:
# https://en.wikipedia.org/wiki/Forsyth%E2%80%93Edwards_Notation

module FEN
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

  def decode_fen_active_color(char)
    char == "w" ? Color::WHITE : Color::BLACK
  end

  def fen_active_color
    @current_player == Color::WHITE ? "w" : "b"
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
      active_color: decode_fen_active_color(arr[1]),
      castling_avail: arr[2],
      en_passant_target: decode_fen_en_passant(arr[3]),
      half_move_clk: arr[4].to_i,
      full_move_num: arr[5].to_i
    }
  end

  def encode_game_state
    "#{encode_fen_position} #{fen_active_color} #{@castling_avail} "\
    "#{encode_fen_en_passant} #{@half_move_clk} #{@full_move_num}"
  end

  def fen_empty_square?(char)
    char.match?(/[1-8]/)
  end

  def next_rank
    "/"
  end

  def decode_fen_en_passant(str)
    return if str == "-"

    @coordinate_translator.translate_square(str)
  end

  def encode_fen_en_passant
    return "-" if @en_passant_target.nil?

    @coordinate_translator.translate_square_index(@en_passant_target[1], @en_passant_target[0])
  end

  def decode_fen_position(fen_str)
    temp_data = []
    fen_str.split(next_rank).each_with_index do |r, i|
      rank = []
      file = 0
      r.split("").each do |char|
        if fen_empty_square?(char)
          char.to_i.times { rank << nil }
          file += char.to_i
        else
          rank << Piece.create(decode_fen_type(char), decode_fen_color(char), [i, file])
          file += 1
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
