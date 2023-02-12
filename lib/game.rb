# frozen_string_literal: true

require_relative "board.rb"

class Game
  def initialize
    @board = Board.new
    @board.initialize_position
  end

  def play

    # play turns until the game is over
    next_turn until @board.game_over?

    endgame
  end

  def next_turn

    # print the board
    puts "#{@board}\n\n"

    move = computer_select_move

    move.execute
  end

  def endgame
    # if one color is in check, the other color wins
    puts "#{@board}\n\n"
    puts "Stalemate" unless @board.in_check?
  end

  def human_select_move

  end

  def computer_select_move
    @board.select_random_move
  end

end
