# frozen_string_literal: true

require_relative "piece"
require_relative "fen"
require_relative "move_interpreter"

class Board
  include FEN

  attr_reader :current_player
  attr_accessor :en_passant_target

  def initialize(data = Array.new(8) { Array.new(8) })
    @data = data
    @current_player = Color::WHITE
    @castling_avail = "KQkq"
    @en_passant_target = nil
    @half_move_clk = 0
    @full_move_num = 1
  end

  def initialize_position
    restore_position("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
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

  def within_bounds?(square)
    rank_index = square[0]
    file_index = square[1]
    rank_index.between?(0, 7) && file_index.between?(0, 7)
  end

  def toggle_current_player
    @current_player = opponent_color
  end

  def remove_castling_avail(move)
    if move.piece.type == PieceType::KING
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
      return false unless @castling_avail.include?("q")

      return false unless squares_between_ex(rook_square, black_king_square).all? { |sq| square_empty?(sq) } && squares_between_in(rook_square, black_king_square).none? { |sq| sq_under_attack?(sq, Color::WHITE) }
    when [0, 7]
      return false unless @castling_avail.include?("k")

      return false unless squares_between_ex(rook_square, black_king_square).all? { |sq| square_empty?(sq) } && squares_between_in(rook_square, black_king_square).none? { |sq| sq_under_attack?(sq, Color::WHITE) }
    when [7, 0]
      return false unless @castling_avail.include?("Q")

      return false unless squares_between_ex(rook_square, white_king_square).all? { |sq| square_empty?(sq) } && squares_between_in(rook_square, white_king_square).none? { |sq| sq_under_attack?(sq, Color::BLACK) }
    when [7, 7]
      return false unless @castling_avail.include?("K")

      return false unless squares_between_ex(rook_square, white_king_square).all? { |sq| square_empty?(sq) } && squares_between_in(rook_square, white_king_square).none? { |sq| sq_under_attack?(sq, Color::BLACK) }
    end
    true
  end

  def replace_piece(sq, piece)
    @data[sq[0]][sq[1]] = piece
  end

  # game_over?
  # after generating move pool, there are zero valid moves
  # if one color is in check -> mate
  # if not -> stalemate
  def game_over?
    generate_move_pool
    @move_pool.length.zero?
  end

  def select_random_move
    generate_move_pool
    @move_pool.sample
  end

  def clear_move_pool
    @move_pool = nil
  end

  # sq under attack?(sq, color)
  # checks if any of the pieces of color are attacking sq
  def sq_under_attack?(square, color)
    @data.flatten.each do |piece|
      next unless piece && piece.color == color

      return true if piece.threatened_squares(self).include?(square)
    end

    false
  end

  # in_check?(color)
  # checks if the King of color is under attack?
  def in_check?(color = @current_player)
    sq_under_attack?(find_piece_coor(PieceType::KING, color)[0], opponent_color(color))
  end

  def find_piece(type, color = @current_player)
    found = []
    @data.each_index do |rank_i|
      @data[rank_i].each_index do |file_i|
        next if @data[rank_i][file_i].nil?

        found << @data[rank_i][file_i] if @data[rank_i][file_i].type == type && @data[rank_i][file_i].color == color
      end
    end
    found
  end

  def find_piece_coor(type, color = @current_player)
    found = []
    @data.each_index do |rank_i|
      @data[rank_i].each_index do |file_i|
        next if @data[rank_i][file_i].nil?

        found << [rank_i, file_i] if @data[rank_i][file_i].type == type && @data[rank_i][file_i].color == color
      end
    end
    found
  end

  # generate move_pool(color)
  # for each piece add moves to pool
  # validate each move in move pool does not leave you in check
  def generate_move_pool(color = @current_player)
    return unless @move_pool.nil?

    @move_pool = []
    @data.flatten.each do |piece|
      next if piece.nil?

      @move_pool += piece.moves(self).keep_if(&:valid?) if piece.color == color
    end
  end

  def translate_squares(translations)
    translations.each do |translation|
      starting_pos = translation[0]
      ending_pos = translation[1]
      @data[ending_pos[0]][ending_pos[1]] = @data[starting_pos[0]][starting_pos[1]]
      @data[ending_pos[0]][ending_pos[1]].position = ending_pos # Update piece's position
      @data[starting_pos[0]][starting_pos[1]] = nil
    end
  end

  def update_full_move_num
    @full_move_num += 1
  end

  def update_half_move_clk
    @half_move_clk += 1
  end

  def reset_half_clk
    @half_move_clk = 0
  end

  def to_s
    str = ""
    8.times do |rank|
      str += (8 - rank).to_s
      8.times do |file|
        color = (rank + file).even? ? "\e[43m" : "\e[41m"
        piece = @data[rank][file]
        piece_str = piece.nil? ? " " : piece.to_s
        str += "#{color} #{piece_str} \e[0m"
      end
      str += "\n"
    end
    str += "  a  b  c  d  e  f  g  h"
    str
  end

  def squares_between_ex(sq1, sq2)
    ret = []
    current_sq = Array.new(sq1)
    loop do
      (current_sq[0] = current_sq[0] < sq2[0] ? current_sq[0] + 1 : current_sq[0] - 1) unless current_sq[0] == sq2[0]
      (current_sq[1] = current_sq[1] < sq2[1] ? current_sq[1] + 1 : current_sq[1] - 1) unless current_sq[1] == sq2[1]

      break if current_sq == sq2

      ret << Array.new(current_sq)
    end
    ret
  end

  def squares_between_in(sq1, sq2)
    ret = [Array.new(sq1)]
    current_sq = Array.new(sq1)
    until current_sq == sq2
      (current_sq[0] = current_sq[0] < sq2[0] ? current_sq[0] + 1 : current_sq[0] - 1) unless current_sq[0] == sq2[0]
      (current_sq[1] = current_sq[1] < sq2[1] ? current_sq[1] + 1 : current_sq[1] - 1) unless current_sq[1] == sq2[1]

      ret << Array.new(current_sq)
    end
    ret
  end

  def square_empty?(square)
    rank_index = square[0]
    file_index = square[1]
    @data[rank_index][file_index].nil?
  end

  def opponent_color(color = current_player)
    color == Color::WHITE ? Color::BLACK : Color::WHITE
  end

  def color_at_sq(square)
    return if square_empty?(square)

    @data[square[0]][square[1]].color
  end

  def rook_starting_squares(color)
    {
      Color::WHITE => [[7, 0], [7, 7]],
      Color::BLACK => [[0, 0], [0, 7]]
    }[color]
  end

  def promotion_rank(color)
    {
      Color::WHITE => 0,
      Color::BLACK => 7
    }[color]
  end
end
