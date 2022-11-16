# frozen_string_literal: true

require_relative "../piece"

class King < Piece

  def self.type
    King
  end
end

Piece.register(King)
