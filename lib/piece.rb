# frozen_string_literal: true

require_relative "constants"

class Piece
  include PieceType
  include Color

  attr_reader :type, :color

  attr_accessor :position

  @class_register = []

  def initialize(type, color, position)
    @type = type
    @color = color
    @position = position
  end

  def to_s
    (0x2654 + color + type).chr(Encoding::UTF_8)
  end

  def self.create(type, color, position = [0, 0])
    @class_register.find { |candidate| candidate.type == type }.new(type, color, position)
  end

  def self.register(candidate)
    @class_register << candidate
  end

  def possible_move_squares
    move_translations.map { |t| translated_position(t) }
  end

  def possible_attack_squares
    attack_translations.map { |a| translated_position(a) }
  end

  def translated_position(trans_matrix)
    x = @position[0] + trans_matrix[0]
    y = @position[1] + trans_matrix[1]
    [x, y]
  end
end
