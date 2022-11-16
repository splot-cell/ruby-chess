# frozen_string_literal: true

require_relative "../lib/piece"
require_relative "../lib/pieces/pawn"
require_relative "../lib/pieces/knight"
require_relative "../lib/pieces/bishop"
require_relative "../lib/pieces/rook"
require_relative "../lib/pieces/queen"
require_relative "../lib/pieces/king"

describe Piece do
  describe "#self.create" do
    context "when no type is given" do
      it "returns a Piece object" do
        expect(Piece.create).to be_a(Piece)
      end

      it "returns a Piece object of type NONE" do
        expect(Piece.create.type).to eq(PieceType::NONE)
      end

      it "returns a Piece object of color nil" do
        expect(Piece.create.color).to be(nil)
      end
    end

    context "when type is PAWN" do
      it "returns an object of type Pawn" do
        expect(Piece.create(PieceType::PAWN)).to be_a(Pawn)
      end
    end

    context "when type is KNIGHT" do
      it "returns an object of type Knight" do
        expect(Piece.create(PieceType::KNIGHT)).to be_a(Knight)
      end
    end

    context "when type is BISHOP" do
      it "returns an object of type Bishop" do
        expect(Piece.create(PieceType::BISHOP)).to be_a(Bishop)
      end
    end

    context "when type is ROOK" do
      it "returns an object of type Rook" do
        expect(Piece.create(PieceType::ROOK)).to be_a(Rook)
      end
    end

    context "when type is QUEEN" do
      it "returns an object of type Queen" do
        expect(Piece.create(PieceType::QUEEN)).to be_a(Queen)
      end
    end

    context "when type is KING" do
      it "returns an object of type King" do
        expect(Piece.create(PieceType::KING)).to be_a(King)
      end
    end
  end
end
