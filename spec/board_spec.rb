# frozen_string_literal: true

require_relative "../lib/board"
require_relative "../lib/piece"

describe Board do
  subject(:board) { described_class.new }
  describe "#initialize" do
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

    context "when a position is passed in" do
      let(:piece_class) { double("piece_class") }

      it "does not create new Piece objects" do
        position = "..."
        expect(piece_class).not_to receive(:new)
        described_class.new(position, piece_class)
      end
    end
  end

  describe "#restore_position" do
    context "when the position contains only a white king in square a8" do
      let(:position1) { "K7/8/8/8/8/8/8/8 w - - 0 1" }

      it "populates @data[0] with a Piece of type KING" do
        expect { board.restore_position(position1) }.to change { board.instance_variable_get(:@data)[0] }.to be_a(King)
      end

      it "populates @data[0] with a Piece of color WHITE" do
        expect { board.restore_position(position1) }.to change { board.instance_variable_get(:@data)[0].color }.to be(PieceColor::WHITE)
      end

      it "populates @data with 64 objects" do
        board.restore_position(position1)
        expect(board.instance_variable_get(:@data).length).to eq(64)
      end

      it "populates @data[1] with a Piece" do
        expect { board.restore_position(position1) }.to change { board.instance_variable_get(:@data)[1] }.to be_a(Piece)
      end

      it "populates @data[1] with a Piece of type NONE" do
        board.restore_position(position1)
        expect(board.instance_variable_get(:@data)[1].type).to be(PieceType::NONE)
      end

      it "populates @data[63] with a Piece of type NONE" do
        board.restore_position(position1)
        expect(board.instance_variable_get(:@data)[63].type).to be(PieceType::NONE)
      end

      it "populates @data[44] with a Piece of type NONE" do
        board.restore_position(position1)
        expect(board.instance_variable_get(:@data)[44].type).to be(PieceType::NONE)
      end
    end

    context "when the position contians a black knight on c4 and a white pawn on h1" do
      let(:position2) { "8/8/8/8/2n5/8/8/7P b - - 2 5" }

      it "populates @data[34] with a Knight" do
        board.restore_position(position2)
        expect(board.instance_variable_get(:@data)[34]).to be_a(Knight)
      end

      it "populates @data[34] with a Piece of color BLACK" do
        expect { board.restore_position(position2) }.to change { board.instance_variable_get(:@data)[34].color }.to be(PieceColor::BLACK)
      end

      it "populates @data[63] with a Pawn" do
        board.restore_position(position2)
        expect(board.instance_variable_get(:@data)[63]).to be_a(Pawn)

      end

      it "populates @data[63] with a Piece of color WHITE" do
        expect { board.restore_position(position2) }.to change { board.instance_variable_get(:@data)[63].color }.to be(PieceColor::WHITE)
      end

      it "populates @data[33] with a Piece of type NONE" do
        board.restore_position(position2)
        expect(board.instance_variable_get(:@data)[33].type).to be(PieceType::NONE)
      end

      it "populates @data[35] with a Piece of type NONE" do
        board.restore_position(position2)
        expect(board.instance_variable_get(:@data)[35].type).to be(PieceType::NONE)
      end

      it "populates @data[2] with a Piece of type NONE" do
        board.restore_position(position2)
        expect(board.instance_variable_get(:@data)[2].type).to be(PieceType::NONE)
      end
    end
  end
end
