# frozen_string_literal: true

require_relative "../lib/board"

describe Board do
  describe "#initialize" do
    subject(:board) { described_class.new }
    context "when no arguments are given" do
      it "creates an array" do
        expect(board.instance_variable_get(:@data)).to be_an(Array)
      end

      it "creates an array of Pieces" do
        expect(board.instance_variable_get(:@data)[0]).to be_a(Piece)
      end

      it "creates an array of length 64" do
        expect(board.instance_variable_get(:@data).length).to eq(64)
      end
    end
  end
  let(:data) {  }
end
