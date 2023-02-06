# frozen_string_literal: true

module Coordinates
  def letter_to_file_index(char)
    char.ord - 97
  end

  def num_to_rank_index(char)
    8 - char.to_i
  end

  def file_index_to_letter(index)
    (index + 97).chr
  end

  def rank_index_to_number_str(index)
    (8 - index).to_s
  end
end
