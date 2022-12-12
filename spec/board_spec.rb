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

      it "creates an array of arrays of nil" do
        expect(board.instance_variable_get(:@data)).to all(all(be(nil)))
      end
    end
  end

  describe "#restore_position" do
    context "when the position contains only a white king in square a8" do
      let(:position) { "K7/8/8/8/8/8/8/8 w - - 0 1" }

      before do
        board.restore_position(position)
      end

      it "populates @data with 8 objects" do
        expect(board.instance_variable_get(:@data).length).to eq(8)
      end

      it "populates each of @data's objects with eight objects" do
        expect(board.instance_variable_get(:@data).all? { |arr| arr.length == 8 }).to be(true)
      end

      it "populates @data[0][0] with a Piece of type KING" do
        expect(board.instance_variable_get(:@data)[0][0]).to be_a(King)
      end

      it "populates @data[0][0] with a Piece of color WHITE" do
        expect(board.instance_variable_get(:@data)[0][0].color).to be(Color::WHITE)
      end

      it "populates@data[0][0] with a Piece of position [0, 0]" do
        expect(board.instance_variable_get(:@data)[0][0].position).to eq([0, 0])
      end

      it "populates @data[0][1] with nil" do
        expect(board.instance_variable_get(:@data)[0][1]).to be(nil)
      end

      it "populates @data[7][7] with nil" do
        expect(board.instance_variable_get(:@data)[7][7]).to be(nil)
      end
    end

    context "when the position contians a black knight on c4 and a white pawn on h1" do
      let(:position) { "8/8/8/8/2n5/8/8/7P b - - 2 5" }

      before do
        board.restore_position(position)
      end

      it "populates @data[4][2] with a Knight" do
        expect(board.instance_variable_get(:@data)[4][2]).to be_a(Knight)
      end

      it "populates @data[4][2] with a Piece of color BLACK" do
        expect(board.instance_variable_get(:@data)[4][2].color).to be(Color::BLACK)
      end

      it "populates@data[4][2] with a Piece of position [4, 2]" do
        expect(board.instance_variable_get(:@data)[4][2].position).to eq([4, 2])
      end

      it "populates @data[7][7] with a Pawn" do
        expect(board.instance_variable_get(:@data)[7][7]).to be_a(Pawn)

      end

      it "populates @data[7][7] with a Piece of color WHITE" do
        expect(board.instance_variable_get(:@data)[7][7].color).to be(Color::WHITE)
      end

      it "populates@data[7][7] with a Piece of position [7, 7]" do
        expect(board.instance_variable_get(:@data)[7][7].position).to eq([7, 7])
      end

      it "populates @data[4][1] with nil" do
        expect(board.instance_variable_get(:@data)[4][1]).to be(nil)
      end

      it "populates @data[4][3] with nil" do
        expect(board.instance_variable_get(:@data)[4][3]).to be(nil)
      end

      it "populates @data[0][2] with nil" do
        expect(board.instance_variable_get(:@data)[0][2]).to be(nil)
      end
    end

    context "when it is black's turn to move" do
      context "when the en passant target is e3" do
        context "when the half move clock is 49" do
          context "when the full move number is 3" do
            let(:position) { "rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 49 3" }

            before do
              board.restore_position(position)
            end

            it "sets @current_player to black" do
              expect(board.instance_variable_get(:@current_player)).to be(Color::BLACK)
            end

            it "sets @en_passent_target to [5, 4]" do
              expect(board.instance_variable_get(:@en_passant_target)).to eq([5, 4])
            end

            it "sets half move clock to 49" do
              expect(board.instance_variable_get(:@half_move_clk)).to eq(49)
            end

            it "sets full move number to 3" do
              expect(board.instance_variable_get(:@full_move_num)).to eq(3)
            end

            it "populates@data[7][7] with a Piece of position [7, 7]" do
              expect(board.instance_variable_get(:@data)[7][7].position).to eq([7, 7])
            end

            it "populates@data[1][3] with a Piece of position [1, 3]" do
              expect(board.instance_variable_get(:@data)[1][3].position).to eq([1, 3])
            end
          end
        end
      end
    end
  end

  describe "#within_bounds?" do
    context "when the coordinate is [0, 0]" do
      it "is within bounds" do
        expect(board.within_bounds?([0, 0])).to be(true)
      end
    end

    context "when the coordinate is [7, 0]" do
      it "is within bounds" do
        expect(board.within_bounds?([7, 0])).to be(true)
      end
    end

    context "when the coordinate is [7, 7]" do
      it "is within bounds" do
        expect(board.within_bounds?([7, 7])).to be(true)
      end
    end

    context "when the coordinate is [4, 3]" do
      it "is within bounds" do
        expect(board.within_bounds?([4, 3])).to be(true)
      end
    end

    context "when the coordinate is [0, 8]" do
      it "is not within bounds" do
        expect(board.within_bounds?([0, 8])).to be(false)
      end
    end

    context "when the coordinate is [8, 0]" do
      it "is not within bounds" do
        expect(board.within_bounds?([8, 0])).to be(false)
      end
    end

    context "when the coordinate is [-2, 1]" do
      it "is not within bounds" do
        expect(board.within_bounds?([-2, 1])).to be(false)
      end
    end
  end

  describe "#encode_fen_position" do
    context "when the board has only a white king on a8" do
      let(:position) { "K7/8/8/8/8/8/8/8 w - - 0 1" }

      before do
        board.restore_position(position)
      end

      it "returns the correct FEN notation of the position" do
        expect(board.encode_fen_position).to eq("K7/8/8/8/8/8/8/8")
      end
    end

    context "when the board has a black pawn on h1" do
      let(:position) { "8/8/8/8/8/8/8/7p w - - 0 1" }

      before do
        board.restore_position(position)
      end

      it "returns the correct FEN notation of the position" do
        expect(board.encode_fen_position).to eq("8/8/8/8/8/8/8/7p")
      end
    end


    context "when the board is in the default starting position" do
      let(:position) { "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1" }

      before do
        board.restore_position(position)
      end

      it "returns the correct FEN notation of the position" do
        expect(board.encode_fen_position).to eq("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR")
      end
    end
  end

  describe "#translate_squares" do
    context "when the board is in the starting position" do
      let(:position) { "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1" }

      before do
        board.restore_position(position)
      end

      context "when the move calls for a pawn push to e4" do
        let(:move) { [[[6, 4], [4, 4]]] }

        it "moves the pawn" do
          expected_position = "rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR"
          expect { board.translate_squares(move) }.to change { board.encode_fen_position }.to eq(expected_position)
        end

        it "changes the @position of piece @data[6][4] from [6, 4] to [4, 4]" do
          piece = board.instance_variable_get(:@data)[6][4]
          expect { board.translate_squares(move) }.to change { piece.position }.from(eq([6, 4])).to eq([4, 4])
        end
      end
    end

    context "when the board is in a position after 1. e4" do
      let(:position) { "rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1" }

      before do
        board.restore_position(position)
      end

      context "when the move calls for a pawn push to c5" do
        let(:move) { [[[1, 2], [3, 2]]] }

        it "moves the pawn" do
          expected_position = "rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR"
          expect { board.translate_squares(move) }.to change { board.encode_fen_position }.to eq(expected_position)
        end
      end
    end

    context "when the position allows a white queenside castle" do
      let(:position) { "r1b1kbnr/ppp1q1pp/2np1p2/4p3/3P4/2N1B3/PPPQPPPP/R3KBNR b KQkq - 0 1" }

      before do
        board.restore_position(position)
      end

      context "when the move calls for a white queenside castle" do
        let(:move) { [[[7, 4], [7, 2]], [[7, 0], [7, 3]]] }

        it "castles queenside" do
          expected_position = "r1b1kbnr/ppp1q1pp/2np1p2/4p3/3P4/2N1B3/PPPQPPPP/2KR1BNR"
          expect { board.translate_squares(move) }.to change { board.encode_fen_position }.to eq(expected_position)
        end

        it "changes the @position of piece @data[7][4] from [7, 4] to [7, 2]" do
          piece = board.instance_variable_get(:@data)[7][4]
          expect { board.translate_squares(move) }.to change { piece.position }.from(eq([7, 4])).to eq([7, 2])
        end

        it "changes the @position of piece @data[7][0] from [7, 0] to [7, 3]" do
          piece = board.instance_variable_get(:@data)[7][0]
          expect { board.translate_squares(move) }.to change { piece.position }.from(eq([7, 0])).to eq([7, 3])
        end
      end
    end

    context "when the position allows black to capture next move" do
      let(:position) { "r1b1kbnr/ppp1q1pp/2np1p2/4p3/3P4/2N1B3/PPPQPPPP/2KR1BNR w kq - 0 1" }

      before do
        board.restore_position(position)
      end

      context "when the move calls for black to capture with a pawn" do
        let(:move) { [[[3, 4], [4, 3]]] }

        it "captures with the pawn" do
          expected_position = "r1b1kbnr/ppp1q1pp/2np1p2/8/3p4/2N1B3/PPPQPPPP/2KR1BNR"
          expect { board.translate_squares(move) }.to change { board.encode_fen_position }.to eq(expected_position)
        end
      end
    end

    context "when the position allows en passant" do
      let(:position) { "r1b1kbnr/ppp1q1pp/2np4/4p3/N2P1pP1/2Q1B3/PPP1PP1P/2KR1BNR b kq g3 0 1" }

      before do
        board.restore_position(position)
      end

      context "when the move calls for black to captue with a pawn" do
        let(:move) { [[[4, 6], [5, 6]], [[4, 5], [5, 6]]] }

        it "captures with the pawn" do
          expected_position = "r1b1kbnr/ppp1q1pp/2np4/4p3/N2P4/2Q1B1p1/PPP1PP1P/2KR1BNR"
          expect { board.translate_squares(move) }.to change { board.encode_fen_position }.to eq(expected_position)
        end
      end
    end
  end

  describe "#sq_under_attack?" do
    context "when the position is rnbqkbnr/pppp1ppp/8/4P3/8/8/PPP1PPPP/RNBQKBNR b KQkq - 0 1" do
      before do
        board.restore_position("rnbqkbnr/pppp1ppp/8/4P3/8/8/PPP1PPPP/RNBQKBNR b KQkq - 0 1")
      end

      it "returns false for sq e5 under attack by black" do
        expect(board.sq_under_attack?([3, 4], Color::BLACK)).to eq(false)
      end

      it "returns false for sq e5 under attack by white" do
        expect(board.sq_under_attack?([3, 4], Color::WHITE)).to eq(false)
      end

      it "returns true for sq c2 under attack by white" do
        expect(board.sq_under_attack?([6, 2], Color::WHITE)).to eq(true)
      end

      it "returns true for sq f6 under attack by white" do
        expect(board.sq_under_attack?([2, 5], Color::WHITE)).to eq(true)
      end

      it "returns true for sq f6 under attack by black" do
        expect(board.sq_under_attack?([2, 5], Color::BLACK)).to eq(true)
      end

      it "returns true for sq h4 under attack by black" do
        expect(board.sq_under_attack?([4, 7], Color::BLACK)).to eq(true)
      end

      it "returns false for sq a5 under attack by black" do
        expect(board.sq_under_attack?([3, 0], Color::BLACK)).to eq(false)
      end

      it "returns false for sq a5 under attack by white" do
        expect(board.sq_under_attack?([3, 0], Color::WHITE)).to eq(false)
      end
    end
  end
end
