# frozen_string_literal: true

require_relative "../piece"

class Pawn < Piece

  def self.type
    PAWN
  end
end

Piece.register(Pawn)
