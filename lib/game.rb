# frozen_string_literal: true

require_relative "board"
require_relative "constants"

class Game
  include Color

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
    puts "Check.\n\n" if @board.in_check?

    move = computer_select_move

    move.execute
  end

  def endgame
    # if one color is in check, the other color wins
    puts "#{@board}\n\n"
    puts result
  end

  def move_format_valid?(str)
    str.match(/^[NBRQK]{0,1}[a-h]{0,1}[1-8]{0,1}[a-h][1-8][NBRQ]{0,1}$/)
  end

  def human_select_move
    choice = gets.chomp
    # if the choice is not in a recognized format
    move = board.interpret_move(choice) if move_format_valid?(choice)
    # if the board cannot identify the piece
    return move unless move.nil?

    puts "I could not interpret that input. Type 'help' to see the instructions."
    human_select_move
  end

  def computer_select_move
    @board.select_random_move
  end

  def result
    return "#{player_string(@board.opponent_color)} wins!" if @board.in_check?

    "Stalemate"
  end

end
