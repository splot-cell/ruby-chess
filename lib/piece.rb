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
end
