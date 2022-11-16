# frozen_string_literal: true

module PieceType
  NONE = 0
  PAWN = 1
  KNIGHT = 2
  BISHOP = 3
  ROOK = 4
  QUEEN = 5
  KING = 6
end

module PieceColor
  WHITE = 0
  BLACK = 1
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

  def self. create(type = NONE)
    @class_register.find { |candidate| candidate.type == type }.new
  end

  def self.register(candidate)
    @class_register << candidate
  end

  def self.type
    NONE
  end
end
