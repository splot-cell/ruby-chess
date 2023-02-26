# frozen_string_literal: true

require_relative "../lib/move_interpreter"
require_relative "../lib/board"
require_relative "../lib/constants"

describe MoveInterpreter do
  subject(:move_interpreter) { described_class.new(board) }
  let(:board) { Board.new }

  describe "#interpret_move" do
    let(:move) { move_interpreter.interpret_move(move_string) }
    context "when the move is non-ambiguous" do
      let(:move_string) { "d3" }
      before do
        board.restore_position("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
      end

      it "returns a move with the correct piece" do
        piece = board.instance_variable_get(:@data)[6][3]
        expect(move.piece).to eq(piece)
      end

      it "returns a move of the correct promotion type" do
        expect(move.promotion).to be(false)
      end

      it "returns a move of the correct double push type" do
        expect(move.pawn_double_push).to be(false)
      end

      it "returns a move with the correct translation list" do
        expect(move.translation_list).to eq([[[6, 3], [5, 3]]])
      end
    end

    context "when the move is a double pawn push" do
      let(:move_string) { "e4" }
      before do
        board.restore_position("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
      end

      it "returns a move with the correct piece" do
        piece = board.instance_variable_get(:@data)[6][4]
        expect(move.piece).to eq(piece)
      end

      it "returns a move of the correct double push type" do
        expect(move.pawn_double_push).to be(true)
      end

      it "returns a move with the correct translation list" do
        expect(move.translation_list).to eq([[[6, 4], [4, 4]]])
      end
    end

    context "when the move is a pawn promotion with no specified promotion target" do
      let(:move_string) { "c8" }
      before do
        board.restore_position("4k3/2P5/R7/6N1/8/2N3N1/8/R3K3 w - - 0 1")
      end

      it "returns a move with the correct piece" do
        piece = board.instance_variable_get(:@data)[1][2]
        expect(move.piece).to eq(piece)
      end

      it "returns a move of the correct promotion type" do
        expect(move.promotion).to be(true)
      end

      it "returns a move with a Queen promotion target" do
        expect(move.instance_variable_get(:@promotion_value)).to eq(PieceType::QUEEN)
      end
    end

    context "when the move is a pawn promotion with a specified Knight promotion target" do
      let(:move_string) { "c8N" }
      before do
        board.restore_position("4k3/2P5/R7/6N1/8/2N3N1/8/R3K3 w - - 0 1")
      end

      it "returns a move with the correct piece" do
        piece = board.instance_variable_get(:@data)[1][2]
        expect(move.piece).to eq(piece)
      end

      it "returns a move of the correct promotion type" do
        expect(move.promotion).to be(true)
      end

      it "returns a move with a Knight promotion target" do
        expect(move.instance_variable_get(:@promotion_value)).to eq(PieceType::KNIGHT)
      end
    end

    context "when the move is ambiguous" do
      let(:move_string) { "Ra4" }
      before do
        board.restore_position("4k3/8/R7/8/8/8/8/R3K3 w - - 0 1")
      end

      it "returns nil" do
        expect(move).to be(nil)
      end
    end

    context "when the move is unambiguous by specifying piece rank" do
      let(:move_string) { "R1a4" }
      before do
        board.restore_position("4k3/8/R7/8/8/8/8/R3K3 w - - 0 1")
      end

      it "returns a move with the correct piece" do
        piece = board.instance_variable_get(:@data)[7][0]
        expect(move.piece).to eq(piece)
      end

      it "returns a move with the correct translation list" do
        expect(move.translation_list).to eq([[[7, 0], [4, 0]]])
      end
    end

    context "when the move is unambiguous by specifying piece file" do
      let(:move_string) { "Nge4" }
      before do
        board.restore_position("4k3/8/R7/6N1/8/2N5/8/R3K3 w - - 0 1")
      end

      it "returns a move with the correct piece" do
        piece = board.instance_variable_get(:@data)[3][6]
        expect(move.piece).to eq(piece)
      end

      it "returns a move with the correct translation list" do
        expect(move.translation_list).to eq([[[3, 6], [4, 4]]])
      end
    end

    context "when the move is unambiguous by specifying piece file and rank" do
      let(:move_string) { "Ng5e4" }
      before do
        board.restore_position("4k3/8/R7/6N1/8/2N3N1/8/R3K3 w - - 0 1")
      end

      it "returns a move with the correct piece" do
        piece = board.instance_variable_get(:@data)[3][6]
        expect(move.piece).to eq(piece)
      end

      it "returns a move with the correct translation list" do
        expect(move.translation_list).to eq([[[3, 6], [4, 4]]])
      end
    end
  end
end
