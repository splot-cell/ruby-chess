# frozen_string_literal: true

require_relative "../piece"

class Rook < Piece
  def initialize
    super(self.class.type)
  end

  def self.type
    ROOK
  end
end

Piece.register(Rook)
