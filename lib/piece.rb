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

  def possible_move_squares(board)
    accessible_squares(move_translations, board).keep_if do |sq|
      board.square_empty?(sq) || board.color_at_sq(sq) == board.opponent_color(@color)
    end
  end

  def threatened_squares(board)
    accessible_squares(attack_translations, board)
  end

  private

  def translated_position(trans_matrix)
    x = @position[0] + trans_matrix[0]
    y = @position[1] + trans_matrix[1]
    [x, y]
  end
end

class SteppingPiece < Piece
  def accessible_squares(translation_list, board)
    translation_list.map { |t| translated_position(t) }.keep_if { |p| board.within_bounds?(p) }
  end

  def sliding?
    false
  end
end

class SlidingPiece < Piece
  def accessible_squares(translation_list, board)
    arr = []
    translation_list.each do |t|
      scale = 1
      while scale < 9
        current_sq = translated_position(scale_translation(scale, t))
        arr << current_sq if board.within_bounds?(current_sq)

        break unless board.within_bounds?(current_sq) && board.square_empty?(current_sq)

        scale += 1
      end
    end
    arr
  end

  def sliding?
    true
  end

  private

  def scale_translation(scale, trans_matrix)
    [scale * trans_matrix[0], scale * trans_matrix[1]]
  end
end
