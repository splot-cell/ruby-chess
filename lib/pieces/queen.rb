# frozen_string_literal: true

require_relative "../piece"

class Queen < Piece
  def initialize
    super(self.class.type)
  end

  def self.type
    QUEEN
  end
end

Piece.register(Queen)
