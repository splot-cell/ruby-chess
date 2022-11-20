# frozen_string_literal: true

require_relative "../lib/board"
require_relative "../lib/piece"

describe Board do
  describe "#initialize" do
    subject(:board) { described_class.new }
    context "when no arguments are given" do
      it "creates an array" do
        expect(board.instance_variable_get(:@data)).to be_an(Array)
      end

      it "creates an array of length 64" do
        expect(board.instance_variable_get(:@data).length).to eq(64)
      end

      it "creates an array of Pieces" do
        expect(board.instance_variable_get(:@data)).to all(be_a(Piece))
      end
    end

    context "when data is passed in" do
      let(:piece_class) { double("piece_class") }

      it "does not create new Piece objects" do
        data = [1, 2, 3]
        expect(piece_class).not_to receive(:new)
        described_class.new(data, piece_class)
      end
    end
  end
end
