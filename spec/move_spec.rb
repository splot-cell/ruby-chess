# frozen_string_literal: true

require_relative "../lib/move"

describe Move do
  describe "#initialize" do
    let(:piece) { double("piece") }
    let(:board) { double("board") }
    subject(:move) { Move.new(piece, list, board) }

    context "when the piece is a pawn" do
      context "when the move is a single square push" do
        let(:list) { [[6, 2], [5, 2]] }
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

      context "when the move is a double square push" do
        let(:list) { [[6, 4], [4, 4]] }
        before do
          allow(piece).to receive(:type).and_return(PieceType::PAWN)
          allow(piece).to receive(:color)
          allow(board).to receive(:promotion_rank)
        end

        it "creates an objet with @pawn_double_push equal to true" do
          expect(move.pawn_double_push).to eq(true)
        end

        it "creates an object with @promotion equal to false" do
          expect(move.promotion).to eq(false)
        end
      end
    end
  end
end
