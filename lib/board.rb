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

  def toggle_current_player
    @current_player = @current_player == Color::WHITE ? Color::BLACK : Color::WHITE
  end

  def remove_castling_avail(move)
    if move.piece.type == Type::KING
      return @castling_avail.delete!("KQ") if move.piece.color == Color::WHITE

      @castling_avail.delete!("kq")
    else
      case move.translation_list[0][0]
      when [0, 0]
        @castling_avail.delete!("q")
      when [0, 7]
        @castling_avail.delete!("k")
      when [7, 0]
        @castling_avail.delete!("Q")
      when [7, 7]
        @castling_avail.delete!("K")
      end
    end
  end

  # castling_valid?(rook_square)
  # checks if castling_avail
  # checks if squares between rook and king are free
  # checks if squares are under attack

  # game_over?
  # after generating move pool, there are zero valid moves
  # if one color is in check -> mate
  # if not -> stalemate

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
