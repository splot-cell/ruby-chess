# frozen_string_literal: true

require_relative "../lib/piece"

describe Piece do
  describe "#self.create_piece" do
    context "when no type is given" do
      it "returns a Piece object" do
        expect(Piece.create_piece).to be_a(Piece)
      end

      it "returns a Piece object of type NONE" do
        expect(Piece.create_piece.type).to eq(PieceType::NONE)
      end

      it "returns a Piece object of color nil" do
        expect(Piece.create_piece.color).to be(nil)
      end
    end

    context "when type is PAWN" do
      it "returns an object of type Pawn" do
        expect(Piece.create_piece(PieceType::PAWN)).to be_a(Pawn)
      end
    end
  end
end
