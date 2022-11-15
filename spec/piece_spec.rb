# frozen_string_literal: true

require_relative "../lib/piece"

describe Piece do
  subject(:piece) { described_class.new }

  describe "#create_piece" do
    context "when the type is NONE" do
      it "returns a Piece object" do
        expect(piece.create_piece).to be_a(Piece)
      end
    end
  end
end
