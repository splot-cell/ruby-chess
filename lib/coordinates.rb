# frozen_string_literal: true

module Coordinates
  def algebraic_sq_to_xy(str)
    [8 - str[1].to_i, letter_to_file(str[0])]
  end

  def letter_to_file(char)
    char.ord - 97
  end
end
