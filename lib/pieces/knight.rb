# frozen_string_literal: true

require_relative "../piece"

class Knight < Piece

  def self.type
    KNIGHT
  end
end

Piece.register(Knight)
