# frozen_string_literal: true

require_relative "../lib/move_interpreter"
require_relative "../lib/board"

describe MoveInterpreter do
  subject(:move_interpreter) { described_class.new(board) }
  let(:board) { Board.new }

  describe "#interpret_move" do
    context "when the move is non-ambiguous" do
      # let(:move) { move_interpreter.interpret_move("d3") }
      let(:move_string) { "d3" }
      before do
        board.restore_position("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
      end

      it "returns a move with the correct piece" do
        move = move_interpreter.interpret_move(move_string)
        piece = board.instance_variable_get(:@data)[6][3]
        expect(move.piece).to eq(piece)
      end

      it "returns a move of the correct promotion type" do
        move = move_interpreter.interpret_move(move_string)
        expect(move.promotion).to be(false)
      end

      it "returns a move of the correct double push type" do
        move = move_interpreter.interpret_move(move_string)
        expect(move.pawn_double_push).to be(false)
      end

      it "returns a move with the correct translation list" do
        move = move_interpreter.interpret_move(move_string)
        expect(move.translation_list).to eq([[[6, 3], [5, 3]]])
      end
    end
  end
end
