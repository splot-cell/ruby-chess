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
    @current_player = opponent_color(@current_player)
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
  def castling_valid?(rook_square)
    black_king_square = [0, 4]
    white_king_square = [7, 4]

    case rook_square
    when [0, 0]
      return false unless @castling_avail.contains?("q")

      return false unless squares_between(rook_square, black_king_square).all? { |sq| square_empty?(sq)  && !sq_under_attack?(sq) }
    when [0, 7]
      return false unless @castling_avail.contains?("k")

      return false unless squares_between(rook_square, black_king_square).all? { |sq| square_empty?(sq)  && !sq_under_attack?(sq) }
    when [7, 0]
      return false unless @castling_avail.contains?("Q")

      return false unless squares_between(rook_square, white_king_square).all? { |sq| square_empty?(sq)  && !sq_under_attack?(sq) }
    when [7, 7]
      return false unless @castling_avail.contains?("K")

      return false unless squares_between(rook_square, white_king_square).all? { |sq| square_empty?(sq) && !sq_under_attack?(sq) }
    end
    true
  end

  # game_over?
  # after generating move pool, there are zero valid moves
  # if one color is in check -> mate
  # if not -> stalemate

  # sq under attack?(sq, color)
  # checks if any of the pieces of color are attacking sq
  def sq_under_attack?(sq, color)
    @data.flatten.each do |piece|
      next unless piece.color == color


    end
  end

  # in_check?(color)
  # checks if the King of color is under attack?
  def in_check?(color)
    sq_under_attack?(find_piece_coor(PieceType::KING, color), opponent_color(color))
  end

  def find_piece_coor(type, color)
    @data.each_index do |rank_i|
      @data[rank_i].each_index do |file_i|
        return [rank_i, file_i] if @data[rank_i][file_i].type == type && @data[rank_i][file_i].color == color
      end
    end
    nil
  end

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
      @data[ending_pos[0]][ending_pos[1]].position = [ending_pos] # Update piece's position
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

  def squares_between(sq1, sq2)
    ret = []
    current_sq = sq1
    until current_sq == sq2
      (current_sq[0] = current_sq[0] < sq2[0] ? current_sq[0] + 1 : current_sq[0] - 1) unless current_sq[0] == sq2[0]
      (current_sq[1] = current_sq[1] < sq2[1] ? current_sq[1] + 1 : current_sq[1] - 1) unless current_sq[1] == sq2[1]
      ret << current_sq
    end
    ret
  end

  def square_empty?(square)
    @data[square].nil?
  end

  def opponent_color(color)
    color == Color::WHITE ? Color::BLACK : Color::WHITE
  end
end
