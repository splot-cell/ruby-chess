# frozen_string_literal: true

module GameText
  def instructions
    <<~HEREDOC
    Making a move:

    To make a move, simply type the piece identifier followed by the square you would like to move to. Piece identifiers are as follows:

    PAWN\tLeave blank
    KNIGHT\tN
    BISHOP\tB
    ROOK\tR
    QUEEN\tQ
    KING\tK

    E.g. to move a pawn to e5, simply type "e5".
    To move your knight to d4, simply type "Nd4".

    SPECIAL SITUATIONS:

    Differentiating two possible pieces:

    If you ever have two pieces of the same type that could access your target square, differentiate the piece to be moved using standard algebraic notation.

    E.g. "Ncd4" would move your knight from file c to the square d4.

    Castling:

    Castling works in the same way as any other move.

    E.g. "Kg1" would result in a white kingside castle.

    Promotions:

    The default piece type to promote to is a queen. However, you can specify another type by adding the piece identifier to the end of your move selection.

    E.g. "e8B" would promote to a bishop.

    To access this again, type "help".

    To save your game, type "save".

    To quit, type "quit".

    HEREDOC
  end

  def welcome
    <<~HEREDOC
      WELCOME TO CHESS!

      To view the instructions, type "help".
    HEREDOC
  end

  def game_mode_prompt
    <<~HEREDOC

      Select an option:
      [1] Start a new game
      [2] Load a saved game

      (type "1" or "2" and hit enter...)
    HEREDOC
  end

  def user_prompt
    "Make your move seletion: "
  end

  def computer_prompt
    "The computer thinks..."
  end
end
