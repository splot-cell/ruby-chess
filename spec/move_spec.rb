# frozen_string_literal: true

require_relative "../lib/move"
require_relative "../lib/board"

describe Move do
  describe "#initialize" do
    let(:piece) { double("piece") }
    let(:board) { double("board") }
    subject(:move) { described_class.new(piece, list, board) }

    context "when the piece is a pawn" do
      context "when the move is a single square push" do
        let(:list) { [[[6, 2], [5, 2]]] }
        before do
          allow(piece).to receive(:type).and_return(PieceType::PAWN)
          allow(piece).to receive(:color)
          allow(board).to receive(:promotion_rank)
        end

        it "creates a Move object" do
          expect(move).to be_a(Move)
        end

        it "creates an object with @pawn_double_push equal to false" do
          expect(move.pawn_double_push).to eq(false)
        end

        it "creates an object with @promotion equal to false" do
          expect(move.promotion).to eq(false)
        end
      end

      context "when the move is a double square push for white" do
        let(:list) { [[[6, 4], [4, 4]]] }
        before do
          allow(piece).to receive(:type).and_return(PieceType::PAWN)
          allow(piece).to receive(:color)
          allow(board).to receive(:promotion_rank)
        end

        it "creates an object with @pawn_double_push equal to true" do
          expect(move.pawn_double_push).to eq(true)
        end

        it "creates an object with @promotion equal to false" do
          expect(move.promotion).to eq(false)
        end
      end

      context "when the move is a double square push for black" do
        let(:list) { [[[1, 1], [3, 1]]] }
        before do
          allow(piece).to receive(:type).and_return(PieceType::PAWN)
          allow(piece).to receive(:color)
          allow(board).to receive(:promotion_rank)
        end

        it "creates an object with @pawn_double_push equal to true" do
          expect(move.pawn_double_push).to eq(true)
        end

        it "creates an object with @promotion equal to false" do
          expect(move.promotion).to eq(false)
        end
      end

      context "when the move is a promotion for white" do
        let(:list) { [[[1, 2], [0, 2]]] }
        before do
          allow(piece).to receive(:type).and_return(PieceType::PAWN)
          allow(piece).to receive(:color).and_return(Color::WHITE)
          allow(board).to receive(:promotion_rank).and_return(0)
        end

        it "creates an object with @pawn_double_push equal to false" do
          expect(move.pawn_double_push).to eq(false)
        end

        it "creates an object with @promotion equal to true" do
          expect(move.promotion).to eq(true)
        end
      end

      context "when the move is a promotion for black" do
        let(:list) { [[[6, 3], [7, 4]]] }
        before do
          allow(piece).to receive(:type).and_return(PieceType::PAWN)
          allow(piece).to receive(:color).and_return(Color::BLACK)
          allow(board).to receive(:promotion_rank).and_return(7)
        end

        it "creates an object with @pawn_double_push equal to false" do
          expect(move.pawn_double_push).to eq(false)
        end

        it "creates an object with @promotion equal to true" do
          expect(move.promotion).to eq(true)
        end
      end
    end

    context "when the piece is not a pawn" do
      let(:list) { [[[6, 0], [0, 6]]] }
      before do
        allow(piece).to receive(:type).and_return(PieceType::BISHOP)
        allow(piece).to receive(:color)
        allow(board).to receive(:promotion_rank)
      end

      it "creates a Move object" do
        expect(move).to be_a(Move)
      end

      it "creates an object with @pawn_double_push equal to false" do
        expect(move.pawn_double_push).to eq(false)
      end

      it "creates an object with @promotion equal to false" do
        expect(move.promotion).to eq(false)
      end
    end
  end

  describe "#execute" do
    let(:board) { Board.new }
    subject(:move) { described_class.new(piece, list, board) }
    context "when the move is a pawn double push" do
      before do
        board.restore_position("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
      end
      let(:piece) { board.instance_variable_get(:@data)[6][4] }
      let(:list) { [[[6, 4], [4, 4]]] }
      it "sets the en passant flag to the correct square" do
        expect { move.execute(board) }.to change { board.en_passant_target }.from(nil).to([5, 4])
      end
    end

    context "when the move is not a pawn double push following a double push" do
      it "unsets the en passant flag" do
      end
    end

    context "when the move is a pawn promotion" do
      context "when the promotion target is a queen" do
        it "changes the piece to a queen" do
        end

        context "when the movement is a capture" do
          it "changes the piece to a queen" do
          end
        end
      end

      context "when the promotion target is a knight" do
        it "changes the piece to a knight" do
        end
      end
    end
  end
end
