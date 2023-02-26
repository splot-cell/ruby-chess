# frozen_string_literal: true

require_relative "board"
require_relative "constants"
require_relative "move_interpreter"
require_relative "game_text"

class Game
  include Color
  include GameText

  def initialize
    @board = Board.new
    @board.initialize_position
    @move_interpreter = MoveInterpreter.new(@board)
  end

  def play
    puts welcome

    game_mode

    # play turns until the game is over
    next_turn until @board.game_over?

    endgame
  end

  def game_mode
    puts game_mode_prompt
    choice = gets.chomp

    return if choice == "1"

    return load_savegame if choice == "2"

    puts "\nI'm sorry, I didn't understand that choice. Try again..."

    game_mode
  end

  def load_savegame
    puts "Saving and loading is not currently supported"
  end

  def next_turn
    # print the board
    puts "\n#{@board}\n\n"
    puts "Check.\n\n" if @board.in_check?

    move = @board.current_player == WHITE ? human_select_move : computer_select_move

    move.execute
  end

  def endgame
    # if one color is in check, the other color wins
    puts "#{@board}\n\n"
    puts result
  end

  def human_select_move
    print user_prompt
    choice = gets.chomp
    # if the choice is in a recognized format
    move = @move_interpreter.interpret_move(choice) if @move_interpreter.move_format_valid?(choice)
    # if the board cannot identify the piece
    return move unless move.nil?

    puts "I could not interpret that input. Type 'help' to see the instructions."
    human_select_move
  end

  def computer_select_move
    puts computer_prompt
    sleep(1.5)
    @board.select_random_move
  end

  def result
    return "#{player_string(@board.opponent_color)} wins!" if @board.in_check?

    "Stalemate"
  end
end
