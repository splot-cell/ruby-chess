# frozen_string_literal: true

require_relative "constants"
require_relative "coordinate_translator"

class MoveInterpreter
  include PieceType

  def initialize(str, coordinate_translator = CoordinateTranslator.new)
    @move_data = str.match(/^([NBRQK])?([a-h])?([1-8])?([a-h][1-8])([NBRQ])?$/).captures
    @coordinate_translator = coordinate_translator
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
    @move_data[4].nil? ? nil : interpret_type(@move_data[4])
  end

  private

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
