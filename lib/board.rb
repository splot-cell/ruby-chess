# frozen_string_literal: true

require_relative "piece"

class Board

  def initialize(data = nil, piece_class = Piece)
    @data = data.nil? ? Array.new(64, piece_class.new) : data
  end

end
