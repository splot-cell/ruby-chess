# frozen_string_literal: true

require_relative "piece"

class Board

  def initialize(position = nil, piece_class = Piece)
    @data = position.nil? ? Array.new(64, piece_class.new) : position
  end

end
