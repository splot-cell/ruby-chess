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
    accessible_squares(move_translations)
  end

  def possible_attack_squares
    accessible_squares(attack_translations)
  end

  private

  def accessible_squares(translation_list)
    return translation_list.map { |t| translated_position(t) } unless sliding?

    sliding_translations(translation_list).map { |t| translated_position(t) }
  end

  def sliding_translations(translation_list)
    return nil unless sliding?

    arr = []
    translation_list.each { |t| 8.times { |i| arr << scale_translation(i + 1, t) } }
    arr
  end

  def scale_translation(scale, trans_matrix)
    [scale * trans_matrix[0], scale * trans_matrix[1]]
  end

  def translated_position(trans_matrix)
    x = @position[0] + trans_matrix[0]
    y = @position[1] + trans_matrix[1]
    [x, y]
  end
end
