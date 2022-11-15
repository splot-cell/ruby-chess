# frozen_string_literal: true

require_relative "../lib/piece"

describe Piece do
  subject(:piece) { described_class.new }

  describe "#self.create_piece" do
    context "when no type is given" do
      it "returns a Piece object" do
        expect(Piece.create_piece).to be_a(Piece)
      end

      it "returns a Piece object of type NONE" do
        expect(Piece.create_piece.type).to eq(PieceType::NONE)
      end
    end
  end
end
