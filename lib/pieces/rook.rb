# frozen_string_literal: true

require_relative "../piece"

class Rook < Piece

  def self.type
    ROOK
  end
end

Piece.register(Rook)
