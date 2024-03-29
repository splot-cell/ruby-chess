# frozen_string_literal: true

# Translates between chess coordinates and array indexes
class CoordinateTranslator
  def translate_square(str)
    square = str.split(//)
    [translate_rank(square[1]), translate_file(square[0])]
  end

  def translate_square_index(file, rank)
    translate_file_index(file) + translate_rank_index(rank)
  end

  def translate_file(char)
    char.ord - 97
  end

  def translate_rank(char)
    8 - char.to_i
  end

  def translate_file_index(index)
    (index + 97).chr
  end

  def translate_rank_index(index)
    (8 - index).to_s
  end
end
