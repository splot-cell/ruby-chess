# frozen_string_literal: true

require_relative "constants"

class MoveInterpreter
  def initialize(str)
    @move_data = str.match(/^([NBRQK])?([a-h])?([1-8])?([a-h][1-8])([NBRQ])?$/).captures
  end

  def piece_type
    @move_data[0]
  end

  def disambiguation_rank
    @move_data[1]
  end

  def disambiguation_file
    @move_data[2]
  end

  def target_square
    @move_data[3]
  end

  def promotion_value
    @move_data[4]
  end
end
