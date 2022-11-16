# frozen_string_literal: true

require_relative "../piece"

class King < Piece
  def initialize
    super(self.class.type)
  end

  def self.type
    KING
  end
end

Piece.register(King)
