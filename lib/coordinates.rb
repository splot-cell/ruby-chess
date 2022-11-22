# frozen_string_literal: true

module Coordinates
  def letter_to_file_index(char)
    char.ord - 97
  end

  def num_to_rank_index(char)
    8 - char.to_i
  end
end
