# frozen_string_literal: true

require_relative "../piece"

class Bishop < Piece
  def initialize
    super(self.class.type)
  end

  def self.type
    BISHOP
  end
end

Piece.register(Bishop)
