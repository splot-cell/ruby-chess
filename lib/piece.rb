# frozen_string_literal: true

module PieceType
  KING = 0
  QUEEN = 1
  ROOK = 2
  BISHOP = 3
  KNIGHT = 4
  PAWN = 5
  NONE = 6
end

module PieceColor
  WHITE = 0
  BLACK = 6
end

class Piece
  include PieceType
  include PieceColor

  attr_reader :type, :color

  @class_register = [Piece]

  def initialize(type = NONE, color = nil)
    @type = type
    @color = color
  end

  def to_s
    return " " if type == NONE

    (0x2654 + color + type).chr(Encoding::UTF_8)
  end

  def self. create(type = NONE, color = nil)
    @class_register.find { |candidate| candidate.type == type }.new(type, color)
  end

  def self.register(candidate)
    @class_register << candidate
  end

  def self.type
    NONE
  end
end
