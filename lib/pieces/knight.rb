# frozen_string_literal: true

require_relative "../piece"

class Knight < Piece
  def initialize
    super(self.class.type)
  end

  def self.type
    KNIGHT
  end
end

Piece.register(Knight)
