# frozen_string_literal: true

require_relative "../lib/board"
require_relative "../lib/piece"

describe Board do
  subject(:board) { described_class.new }
  describe "#initialize" do
    matcher :be_length_8 do
      match { |arr| arr.length == 8 }
    end

    context "when no arguments are given" do
      it "creates an array" do
        expect(board.instance_variable_get(:@data)).to be_an(Array)
      end

      it "creates an array of length 8" do
        expect(board.instance_variable_get(:@data)).to be_length_8
      end

      it "creates an array of Arrays" do
        expect(board.instance_variable_get(:@data)).to all(be_an(Array))
      end

      it "creates an array of arrays of length 8" do
        expect(board.instance_variable_get(:@data)).to all(be_length_8)
      end

      it "creates an array of arrays of Pieces" do
        expect(board.instance_variable_get(:@data)).to all(all(be_a(Piece)))
      end
    end
  end

  describe "#restore_position" do
    context "when the position contains only a white king in square a8" do
      let(:position1) { "K7/8/8/8/8/8/8/8 w - - 0 1" }

      it "populates @data[0][0] with a Piece of type KING" do
        expect { board.restore_position(position1) }.to change { board.instance_variable_get(:@data)[0][0] }.to be_a(King)
      end

      it "populates @data[0][0] with a Piece of color WHITE" do
        expect { board.restore_position(position1) }.to change { board.instance_variable_get(:@data)[0][0].color }.to be(PieceColor::WHITE)
      end

      it "populates @data with 64 objects" do
        board.restore_position(position1)
        expect(board.instance_variable_get(:@data).flatten.length).to eq(64)
      end

      it "populates @data[0][1] with a Piece" do
        expect { board.restore_position(position1) }.to change { board.instance_variable_get(:@data)[0][1] }.to be_a(Piece)
      end

      it "populates @data[0][1] with a Piece of type NONE" do
        board.restore_position(position1)
        expect(board.instance_variable_get(:@data)[0][1].type).to be(PieceType::NONE)
      end

      it "populates @data[7][7] with a Piece of type NONE" do
        board.restore_position(position1)
        expect(board.instance_variable_get(:@data)[7][7].type).to be(PieceType::NONE)
      end

      it "populates @data[5][4] with a Piece of type NONE" do
        board.restore_position(position1)
        expect(board.instance_variable_get(:@data)[5][4].type).to be(PieceType::NONE)
      end
    end

    context "when the position contians a black knight on c4 and a white pawn on h1" do
      let(:position2) { "8/8/8/8/2n5/8/8/7P b - - 2 5" }

      it "populates @data[4][2] with a Knight" do
        board.restore_position(position2)
        expect(board.instance_variable_get(:@data)[4][2]).to be_a(Knight)
      end

      it "populates @data[4][2] with a Piece of color BLACK" do
        expect { board.restore_position(position2) }.to change { board.instance_variable_get(:@data)[4][2].color }.to be(PieceColor::BLACK)
      end

      it "populates @data[7][7] with a Pawn" do
        board.restore_position(position2)
        expect(board.instance_variable_get(:@data)[7][7]).to be_a(Pawn)

      end

      it "populates @data[7][7] with a Piece of color WHITE" do
        expect { board.restore_position(position2) }.to change { board.instance_variable_get(:@data)[7][7].color }.to be(PieceColor::WHITE)
      end

      it "populates @data[4][1] with a Piece of type NONE" do
        board.restore_position(position2)
        expect(board.instance_variable_get(:@data)[4][1].type).to be(PieceType::NONE)
      end

      it "populates @data[4][3] with a Piece of type NONE" do
        board.restore_position(position2)
        expect(board.instance_variable_get(:@data)[4][3].type).to be(PieceType::NONE)
      end

      it "populates @data[0][2] with a Piece of type NONE" do
        board.restore_position(position2)
        expect(board.instance_variable_get(:@data)[0][2].type).to be(PieceType::NONE)
      end
    end
  end
end
