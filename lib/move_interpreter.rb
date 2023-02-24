# frozen_string_literal: true

require_relative "constants"
require_relative "coordinate_translator"
require_relative "move"

class MoveInterpreter
  include PieceType

  def initialize(board, coordinate_translator = CoordinateTranslator.new)
    @coordinate_translator = coordinate_translator
    @board = board
    @piece = nil
  end

  def interpret_move(str, board = @board)
    @board = board
    @move_data = str.match(/^([NBRQK])?([a-h])?([1-8])?([a-h][1-8])([NBRQ])?$/).captures
    return nil unless identify_piece
    # if one piece, return the move
    move
  end

  private

  def move
    Move.new(@piece, target_square, @board, promotion_value)
  end

  def identify_piece
    piece_list = @board.find_piece(piece_type).keep_if { |piece| piece.possible_move_squares(@board).include?(target_square) }
    # if more than one piece, filter by disambig
    return false unless piece_list.length == 1

    @piece = piece_list[0]
    true
  end

  def piece_type
    interpret_type(@move_data[0])
  end

  def disambiguation_rank
    @coordinate_translator.translate_rank(@move_data[1])
  end

  def disambiguation_file
    @coordinate_translator.translate_file(@move_data[2])
  end

  def target_square
    @coordinate_translator.translate_square(@move_data[3])
  end

  def promotion_value
    @move_data[4].nil? ? PieceType::QUEEN : interpret_type(@move_data[4])
  end

  def interpret_type(char)
    return PieceType::PAWN if char.nil?
    {
      "K" => PieceType::KING,
      "Q" => PieceType::QUEEN,
      "R" => PieceType::ROOK,
      "B" => PieceType::BISHOP,
      "N" => PieceType::KNIGHT,
    }[char]
  end
end
