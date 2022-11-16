# frozen_string_literal: true

require_relative "../piece"

class Pawn < Piece
  def initialize
    super(self.class.type)
  end

  def self.type
    PAWN
  end
end

Piece.register(Pawn)
