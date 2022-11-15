# frozen_string_literal: true

require_relative "piece"

class Board

  def initialize(piece_class = Piece)
    @data = Array.new(64, piece_class.new)
  end

end
