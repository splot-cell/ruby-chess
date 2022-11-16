# frozen_string_literal: true

require_relative "../piece"

class Bishop < Piece

  def self.type
    BISHOP
  end
end

Piece.register(Bishop)
