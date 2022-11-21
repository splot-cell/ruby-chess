# frozen_string_literal: true

require_relative "../piece"

class Queen < Piece
  def self.type
    QUEEN
  end
end

Piece.register(Queen)
