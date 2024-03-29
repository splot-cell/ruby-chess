# frozen_string_literal: true

require_relative "../lib/move"
require_relative "../lib/board"

describe Move do
  describe "#initialize" do
    let(:piece) { double("piece") }
    let(:board) { double("board") }
    subject(:move) { described_class.new(piece, target_sq, board) }

    context "when the piece is a pawn" do
      context "when the move is a single square push" do
        let(:target_sq) { [5, 2] }
        before do
          allow(piece).to receive(:type).and_return(PieceType::PAWN)
          allow(piece).to receive(:position).and_return([6, 2])
          allow(piece).to receive(:color)
          allow(board).to receive(:promotion_rank)
        end

        it "creates a Move object" do
          expect(move).to be_a(Move)
        end

        it "creates an object with @pawn_double_push equal to false" do
          expect(move.pawn_double_push).to eq(false)
        end

        it "creates an object with @promotion equal to false" do
          expect(move.promotion).to eq(false)
        end
      end

      context "when the move is a double square push for white" do
        let(:target_sq) { [4, 4] }
        before do
          allow(piece).to receive(:type).and_return(PieceType::PAWN)
          allow(piece).to receive(:position).and_return([6, 4])
          allow(piece).to receive(:color)
          allow(board).to receive(:promotion_rank)
        end

        it "creates an object with @pawn_double_push equal to true" do
          expect(move.pawn_double_push).to eq(true)
        end

        it "creates an object with @promotion equal to false" do
          expect(move.promotion).to eq(false)
        end
      end

      context "when the move is a double square push for black" do
        let(:target_sq) { [3, 1] }
        before do
          allow(piece).to receive(:type).and_return(PieceType::PAWN)
          allow(piece).to receive(:position).and_return([1, 1])
          allow(piece).to receive(:color)
          allow(board).to receive(:promotion_rank)
        end

        it "creates an object with @pawn_double_push equal to true" do
          expect(move.pawn_double_push).to eq(true)
        end

        it "creates an object with @promotion equal to false" do
          expect(move.promotion).to eq(false)
        end
      end

      context "when the move is a promotion for white" do
        let(:target_sq) { [0, 2] }
        before do
          allow(piece).to receive(:type).and_return(PieceType::PAWN)
          allow(piece).to receive(:position).and_return([1, 2])
          allow(piece).to receive(:color).and_return(Color::WHITE)
          allow(board).to receive(:promotion_rank).and_return(0)
        end

        it "creates an object with @pawn_double_push equal to false" do
          expect(move.pawn_double_push).to eq(false)
        end

        it "creates an object with @promotion equal to true" do
          expect(move.promotion).to eq(true)
        end
      end

      context "when the move is a promotion for black" do
        let(:target_sq) { [7, 4] }
        before do
          allow(piece).to receive(:type).and_return(PieceType::PAWN)
          allow(piece).to receive(:position).and_return([6, 3])
          allow(piece).to receive(:color).and_return(Color::BLACK)
          allow(board).to receive(:promotion_rank).and_return(7)
        end

        it "creates an object with @pawn_double_push equal to false" do
          expect(move.pawn_double_push).to eq(false)
        end

        it "creates an object with @promotion equal to true" do
          expect(move.promotion).to eq(true)
        end
      end
    end

    context "when the piece is not a pawn" do
      let(:target_sq) { [0, 6] }
      before do
        allow(piece).to receive(:type).and_return(PieceType::BISHOP)
        allow(piece).to receive(:position).and_return([6, 0])
        allow(piece).to receive(:color)
        allow(board).to receive(:promotion_rank)
      end

      it "creates a Move object" do
        expect(move).to be_a(Move)
      end

      it "creates an object with @pawn_double_push equal to false" do
        expect(move.pawn_double_push).to eq(false)
      end

      it "creates an object with @promotion equal to false" do
        expect(move.promotion).to eq(false)
      end
    end

    context "when the piece is a white king" do
      before do
        allow(piece).to receive(:type).and_return(PieceType::KING)
        allow(piece).to receive(:color).and_return(Color::WHITE)
      end

      context "when the piece is in its starting position" do
        before do
          allow(piece).to receive(:position).and_return([7, 4])
        end

        context "when the move is a basic step" do
          let(:target_sq) { [7, 5] }

          it "creates a Move object with a translation list containing the starting square and target square" do
            expect(move.translation_list).to eq([[[7, 4], [7, 5]]])
          end
        end

        context "when the move is a kingside castle" do
          let(:target_sq) { [7, 6] }

          it "creates a Move object with a translation list containing the king's move and the rook's move" do
            expect(move.translation_list).to eq([[[7, 4], [7, 6]], [[7, 7], [7, 5]]])
          end
        end

        context "when the move is a queenside castle" do
          let(:target_sq) { [7, 2] }

          it "creates a Move object with a translation list containing the king's move and the rook's move" do
            expect(move.translation_list).to eq([[[7, 4], [7, 2]], [[7, 0], [7, 3]]])
          end
        end
      end
    end

    context "when the piece is a black king" do
      before do
        allow(piece).to receive(:type).and_return(PieceType::KING)
        allow(piece).to receive(:color).and_return(Color::BLACK)
      end

      context "when the piece is in its starting position" do
        before do
          allow(piece).to receive(:position).and_return([0, 4])
        end

        context "when the move is a kingside castle" do
          let(:target_sq) { [0, 6] }

          it "creates a Move object with a translation list containing the king's move and the rook's move" do
            expect(move.translation_list).to eq([[[0, 4], [0, 6]], [[0, 7], [0, 5]]])
          end
        end

        context "when the move is a queenside castle" do
          let(:target_sq) { [0, 2] }

          it "creates a Move object with a translation list containing the king's move and the rook's move" do
            expect(move.translation_list).to eq([[[0, 4], [0, 2]], [[0, 0], [0, 3]]])
          end
        end
      end
    end
  end

  describe "#execute" do
    let(:board) { Board.new }
    subject(:move) { described_class.new(piece, target_sq, board) }
    context "when the move is a pawn double push" do
      before do
        board.restore_position("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
      end
      let(:piece) { board.instance_variable_get(:@data)[6][4] }
      let(:target_sq) { [4, 4] }

      it "sets the en passant flag to the correct square" do
        expect { move.execute(board) }.to change { board.en_passant_target }.from(nil).to([5, 4])
      end
    end

    context "when the move is not a pawn double push but follows a double push" do
      before do
        board.restore_position("rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1")
      end
      let(:piece) { board.instance_variable_get(:@data)[1][4] }
      let(:target_sq) { [2, 4] }

      it "unsets the en passant flag" do
        expect { move.execute(board) }.to change { board.en_passant_target }.from([5, 4]).to(nil)
      end
    end

    context "when the move is a pawn promotion" do
      before do
        board.restore_position("2r3k1/ppBP1ppp/2p5/2n1pb2/1P6/N1P2P2/P5PP/R3K1R1 w Q - 0 1")
      end
      let(:piece) { board.instance_variable_get(:@data)[1][3] }
      let(:target_sq) { [0, 3] }

      context "when the promotion target is a queen" do
        it "changes the piece to a queen" do
          expect { move.execute(board) }.to change { board.encode_fen_position }.to("2rQ2k1/ppB2ppp/2p5/2n1pb2/1P6/N1P2P2/P5PP/R3K1R1")
        end

        context "when the movement is a capture" do
          let(:target_sq) { [0, 2] }
          it "changes the piece to a queen" do
            expect { move.execute(board) }.to change { board.encode_fen_position }.to("2Q3k1/ppB2ppp/2p5/2n1pb2/1P6/N1P2P2/P5PP/R3K1R1")
          end
        end
      end

      context "when the promotion target is a knight" do
        subject(:move) { described_class.new(piece, target_sq, board, PieceType::KNIGHT) }
        it "changes the piece to a knight" do
          expect { move.execute(board) }.to change { board.encode_fen_position }.to("2rN2k1/ppB2ppp/2p5/2n1pb2/1P6/N1P2P2/P5PP/R3K1R1")
        end
      end
    end

    context "when the move is not a promotion" do
      before do
        board.restore_position("rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1")
      end
      let(:piece) { board.instance_variable_get(:@data)[1][4] }
      let(:target_sq) { [2, 4] }

      it "moves the piece" do
        expect { move.execute(board) }.to change { board.encode_fen_position }.to("rnbqkbnr/pppp1ppp/4p3/8/4P3/8/PPPP1PPP/RNBQKBNR")
      end
    end
  end
end
