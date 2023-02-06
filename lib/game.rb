# frozen_string_literal: true

require_relative "board.rb"

class Game
  def initialize
    @board = Board.new
  end

  def play

    # play turns until the game is over
    next_turn until board.game_over?

    # if one color is in check, the other color wins
  end

  def next_turn

    # print the board
    puts board

    # get player input
        # validate input

      # execute move

  end

end
