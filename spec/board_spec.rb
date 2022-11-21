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

  describe "#within_bounds?" do
    context "when the coordinate is [0][0]" do
      it "returns true" do
        expect(board.within_bounds?(0, 0)).to be(true)
      end
    end

    context "when the coordinate is [7][0]" do
      it "returns true" do
        expect(board.within_bounds?(7, 0)).to be(true)
      end
    end

    context "when the coordinate is [7][7]" do
      it "returns true" do
        expect(board.within_bounds?(7, 7)).to be(true)
      end
    end

    context "when the coordinate is [4][3]" do
      it "returns true" do
        expect(board.within_bounds?(4, 3)).to be(true)
      end
    end

    context "when the coordinate is [0][8]" do
      it "returns false" do
        expect(board.within_bounds?(0, 8)).to be(false)
      end
    end

    context "when the coordinate is [8][0]" do
      it "returns false" do
        expect(board.within_bounds?(8, 0)).to be(false)
      end
    end

    context "when the coordinate is [-2][1]" do
      it "returns false" do
        expect(board.within_bounds?(-2, 1)).to be(false)
      end
    end
  end

  describe "#pos_to_fen" do
    context "when the board has a white king on a8" do
      let(:position1) { "K7/8/8/8/8/8/8/8 w - - 0 1" }

      before do
        board.restore_position(position1)
      end

      it "returns the correct FEN notation of the position" do
        expect(board.pos_to_fen).to eq("K7/8/8/8/8/8/8/8")
      end
    end

    context "when the board is in the default starting position" do
      let(:position2) { "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1" }

      before do
        board.restore_position(position2)
      end

      it "returns the correct FEN notation of the position" do
        expect(board.pos_to_fen).to eq("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR")
      end
    end
  end

  describe "#make_move" do
    context "when the board is in the starting position" do
      let(:position) { "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1" }

      before do
        board.restore_position(position)
      end

      context "when the move calls for a pawn push to e4" do
        let(:move1) { [[[6, 4], [4, 4]]] }

        it "moves the pawn" do
          expected_position = "rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR"
          expect { board.make_move(move1) }.to change { board.pos_to_fen }.to eq(expected_position)
        end
      end
    end

    context "when the board is in a position after 1. e4" do
      let(:position2) { "rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1" }

      before do
        board.restore_position(position2)
      end

      context "when the move calls for a pawn push to c5" do
        let(:move2) { [[[1, 2], [3, 2]]] }

        it "moves the pawn" do
          expected_position = "rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR"
          expect { board.make_move(move2) }.to change { board.pos_to_fen }.to eq(expected_position)
        end
      end
    end

    context "when the next move could be a white queenside castle" do
      let(:position3) { "r1b1kbnr/ppp1q1pp/2np1p2/4p3/3P4/2N1B3/PPPQPPPP/R3KBNR b KQkq - 0 1" }

      before do
        board.restore_position(position3)
      end

      context "when the move calls for a white queenside castle" do
        let(:move3) { [[[7, 4], [7, 2]], [[7, 0], [7, 3]]] }

        it "castles queenside" do
          expected_position = "r1b1kbnr/ppp1q1pp/2np1p2/4p3/3P4/2N1B3/PPPQPPPP/2KR1BNR"
          expect { board.make_move(move3) }.to change { board.pos_to_fen }.to eq(expected_position)
        end
      end
    end

    context "when the position allows black to capture next move" do
      let(:position4) { "r1b1kbnr/ppp1q1pp/2np1p2/4p3/3P4/2N1B3/PPPQPPPP/2KR1BNR w kq - 0 1" }

      before do
        board.restore_position(position4)
      end

      context "when the move calls for a black pawn capture" do
        let(:move4) { [[[3, 4], [4, 3]]] }

        it "captures" do
          expected_position = "r1b1kbnr/ppp1q1pp/2np1p2/8/3p4/2N1B3/PPPQPPPP/2KR1BNR"
          expect { board.make_move(move4) }.to change { board.pos_to_fen }.to eq(expected_position)
        end
      end
    end

    context "when the position allows to enact en passant" do
      let(:position5) { "r1b1kbnr/ppp1q1pp/2np4/4p3/N2P1pP1/2Q1B3/PPP1PP1P/2KR1BNR b kq g3 0 1" }

      before do
        board.restore_position(position5)
      end

      context "when the move calls for a black pawn capture" do
        let(:move5) { [[[4, 6], [5, 6]], [[4, 5], [5, 6]]] }

        it "captures" do
          expected_position = "r1b1kbnr/ppp1q1pp/2np4/4p3/N2P4/2Q1B1p1/PPP1PP1P/2KR1BNR"
          expect { board.make_move(move5) }.to change { board.pos_to_fen }.to eq(expected_position)
        end
      end
    end
  end
end
