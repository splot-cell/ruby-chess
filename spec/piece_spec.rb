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
    let(:color) { double("color") }

    context "when type is PAWN" do
      it "returns an object of type Pawn" do
        expect(Piece.create(PieceType::PAWN, color)).to be_a(Pawn)
      end

      it "returns a Piece object with type PAWN" do
        expect(Piece.create(PieceType::PAWN, color).type).to eq(PieceType::PAWN)
      end

      context "when the color is WHITE" do
        it "returns a Piece object of color WHITE" do
          expect(Piece.create(PieceType::PAWN, Color::WHITE).color).to eq(Color::WHITE)
        end
      end

      context "when the color is BLACK" do
        it "returns a Piece obejct of color BLACK" do
          expect(Piece.create(PieceType::PAWN, Color::BLACK).color).to eq(Color::BLACK)
        end
      end
    end

    context "when type is KNIGHT" do
      it "returns an object of type Knight" do
        expect(Piece.create(PieceType::KNIGHT, color)).to be_a(Knight)
      end

      it "returns a Piece object with type KNIGHT" do
        expect(Piece.create(PieceType::KNIGHT, color).type).to eq(PieceType::KNIGHT)
      end

      context "when the color is WHITE" do
        it "returns a Piece object of color WHITE" do
          expect(Piece.create(PieceType::KNIGHT, Color::WHITE).color).to eq(Color::WHITE)
        end
      end

      context "when the color is BLACK" do
        it "returns a Piece obejct of color BLACK" do
          expect(Piece.create(PieceType::KNIGHT, Color::BLACK).color).to eq(Color::BLACK)
        end
      end
    end

    context "when type is BISHOP" do
      it "returns an object of type Bishop" do
        expect(Piece.create(PieceType::BISHOP, color)).to be_a(Bishop)
      end

      it "returns a Piece object with type BISHOP" do
        expect(Piece.create(PieceType::BISHOP, color).type).to eq(PieceType::BISHOP)
      end

      context "when the color is WHITE" do
        it "returns a Piece object of color WHITE" do
          expect(Piece.create(PieceType::BISHOP, Color::WHITE).color).to eq(Color::WHITE)
        end
      end

      context "when the color is BLACK" do
        it "returns a Piece obejct of color BLACK" do
          expect(Piece.create(PieceType::BISHOP, Color::BLACK).color).to eq(Color::BLACK)
        end
      end
    end

    context "when type is ROOK" do
      it "returns an object of type Rook" do
        expect(Piece.create(PieceType::ROOK, color)).to be_a(Rook)
      end

      it "returns a Piece object with type ROOK" do
        expect(Piece.create(PieceType::ROOK, color).type).to eq(PieceType::ROOK)
      end

      context "when the color is WHITE" do
        it "returns a Piece object of color WHITE" do
          expect(Piece.create(PieceType::ROOK, Color::WHITE).color).to eq(Color::WHITE)
        end
      end

      context "when the color is BLACK" do
        it "returns a Piece obejct of color BLACK" do
          expect(Piece.create(PieceType::ROOK, Color::BLACK).color).to eq(Color::BLACK)
        end
      end
    end

    context "when type is QUEEN" do
      it "returns an object of type Queen" do
        expect(Piece.create(PieceType::QUEEN, color)).to be_a(Queen)
      end

      it "returns a Piece object with type QUEEN" do
        expect(Piece.create(PieceType::QUEEN, color).type).to eq(PieceType::QUEEN)
      end

      context "when the color is WHITE" do
        it "returns a Piece object of color WHITE" do
          expect(Piece.create(PieceType::QUEEN, Color::WHITE).color).to eq(Color::WHITE)
        end
      end

      context "when the color is BLACK" do
        it "returns a Piece obejct of color BLACK" do
          expect(Piece.create(PieceType::QUEEN, Color::BLACK).color).to eq(Color::BLACK)
        end
      end
    end

    context "when type is KING" do
      it "returns an object of type King" do
        expect(Piece.create(PieceType::KING, color)).to be_a(King)
      end

      it "returns a Piece object with type KING" do
        expect(Piece.create(PieceType::KING, color).type).to eq(PieceType::KING)
      end

      context "when the color is WHITE" do
        it "returns a Piece object of color WHITE" do
          expect(Piece.create(PieceType::KING, Color::WHITE).color).to eq(Color::WHITE)
        end
      end

      context "when the color is BLACK" do
        it "returns a Piece obejct of color BLACK" do
          expect(Piece.create(PieceType::KING, Color::BLACK).color).to eq(Color::BLACK)
        end
      end
    end
  end

  describe "#to_s" do
    context "when the piece is a white king" do
      subject(:white_king) { described_class.create(PieceType::KING, Color::WHITE) }
      it "returns ♔" do
        expect(white_king.to_s).to eq("♔")
      end
    end

    context "when the piece is a white queen" do
      subject(:white_queen) { described_class.create(PieceType::QUEEN, Color::WHITE) }
      it "returns ♕" do
        expect(white_queen.to_s).to eq("♕")
      end
    end

    context "when the piece is a white rook" do
      subject(:white_rook) { described_class.create(PieceType::ROOK, Color::WHITE) }
      it "returns ♖" do
        expect(white_rook.to_s).to eq("♖")
      end
    end

    context "when the piece is a white bishop" do
      subject(:white_bishop) { described_class.create(PieceType::BISHOP, Color::WHITE) }
      it "returns ♗" do
        expect(white_bishop.to_s).to eq("♗")
      end
    end

    context "when the piece is a white knight" do
      subject(:white_knight) { described_class.create(PieceType::KNIGHT, Color::WHITE) }
      it "returns ♘" do
        expect(white_knight.to_s).to eq("♘")
      end
    end

    context "when the piece is a white pawn" do
      subject(:white_pawn) { described_class.create(PieceType::PAWN, Color::WHITE) }
      it "returns ♙" do
        expect(white_pawn.to_s).to eq("♙")
      end
    end

    context "when the piece is a black king" do
      subject(:black_king) { described_class.create(PieceType::KING, Color::BLACK) }
      it "returns ♚" do
        expect(black_king.to_s).to eq("♚")
      end
    end

    context "when the piece is a black queen" do
      subject(:black_queen) { described_class.create(PieceType::QUEEN, Color::BLACK) }
      it "returns ♛" do
        expect(black_queen.to_s).to eq("♛")
      end
    end

    context "when the piece is a black rook" do
      subject(:black_rook) { described_class.create(PieceType::ROOK, Color::BLACK) }
      it "returns ♜" do
        expect(black_rook.to_s).to eq("♜")
      end
    end

    context "when the piece is a black bishop" do
      subject(:black_bishop) { described_class.create(PieceType::BISHOP, Color::BLACK) }
      it "returns ♝" do
        expect(black_bishop.to_s).to eq("♝")
      end
    end

    context "when the piece is a black knight" do
      subject(:black_knight) { described_class.create(PieceType::KNIGHT, Color::BLACK) }
      it "returns ♞" do
        expect(black_knight.to_s).to eq("♞")
      end
    end

    context "when the piece is a black pawn" do
      subject(:black_pawn) { described_class.create(PieceType::PAWN, Color::BLACK) }
      it "returns ♟" do
        expect(black_pawn.to_s).to eq("♟")
      end
    end
  end

  describe "#possible_move_squares" do
    let(:real_board) { Board.new }

    context "when the piece is a white pawn" do
      subject(:white_pawn) { described_class.create(PieceType::PAWN, Color::WHITE) }
      context "when it is on a2" do
        it "returns [[5, 0], [4, 0]]" do
          real_board.restore_position("8/8/8/8/8/8/P7/8 b - - 0 1")
          white_pawn.position = [6, 0]
          expect(white_pawn.possible_move_squares(real_board)).to eq([[5, 0], [4, 0]])
        end
      end

      context "when it is on a3" do
        it "returns [[4, 0]]" do
          real_board.restore_position("8/8/8/8/8/P7/8/8 b - - 0 1")
          white_pawn.position = [5, 0]
          expect(white_pawn.possible_move_squares(real_board)).to eq([[4, 0]])
        end

        context "when an enemy piece is on b4" do
          before do
            real_board.restore_position("8/8/8/8/1n6/P7/8/8 w - - 0 1")
            white_pawn.position = [5, 0]
          end

          it "returns [[4, 0], [4, 1]]" do
            expect(white_pawn.possible_move_squares(real_board)).to eq([[4, 0], [4, 1]])
          end
        end
      end

      context "when en passant is executable" do
        before do
          real_board.restore_position("rnbqkbnr/pppp1ppp/8/3Pp3/8/8/PPP1PPPP/RNBQKBNR w KQkq e6 0 1")
          white_pawn.position = [3, 3]
        end

        it "includes the en passant square" do
          expect(white_pawn.possible_move_squares(real_board).include?([2, 4])).to eq(true)
        end

        it "returns [[2, 3], [2, 4]]" do
          expect(white_pawn.possible_move_squares(real_board)).to eq([[2, 3], [2, 4]])
        end
      end
    end

    context "when the piece is a black pawn" do
      subject(:black_pawn) { described_class.create(PieceType::PAWN, Color::BLACK) }
      context "when it is on b2" do
        it "returns [[7, 1]]" do
          real_board.restore_position("8/8/8/8/8/8/1p6/8 b - - 0 1")
          black_pawn.position = [6, 1]
          expect(black_pawn.possible_move_squares(real_board)).to eq([[7, 1]])
        end
      end

      context "when it is on b7" do
        it "returns [[2, 1], [3, 1]]" do
          real_board.restore_position("8/1p6/8/8/8/8/8/8 b - - 0 1")
          black_pawn.position = [1, 1]
          expect(black_pawn.possible_move_squares(real_board)).to eq([[2, 1], [3, 1]])
        end
      end
    end

    context "when the piece is a knight" do
      subject(:knight) { described_class.create(PieceType::KNIGHT, Color::BLACK) }
      context "when it is on d4" do
        it "returns [[2, 2], [2, 4], [3, 5], [5, 5], [6, 4], [6, 2], [5, 1], [3, 1]]" do
          real_board.restore_position("8/8/8/8/3n4/8/8/8 b - - 0 1")
          knight.position = [4, 3]
          expect(knight.possible_move_squares(real_board).sort).to eq([[2, 2], [2, 4], [3, 5], [5, 5], [6, 4], [6, 2], [5, 1], [3, 1]].sort)
        end
      end
    end

    context "when the piece is a white bishop" do
      subject(:bishop) { described_class.create(PieceType::BISHOP, Color::WHITE) }

      context "when the bishop is in an empty board at position b3" do
        before do
          position = "8/8/8/8/8/1B6/8/8 w - - 0 1"
          real_board.restore_position(position)
          bishop.position = [5, 1]
        end

        it "returns correct diagonal squares up to edge of board" do
          expected_sqs = [[4, 0], [6, 0], [4, 2], [3, 3], [2, 4], [1, 5], [0, 6], [6, 2], [7, 3]].sort

          expect(bishop.possible_move_squares(real_board).sort).to eq(expected_sqs)
        end
      end

      context "when the bishop is at position b3, with kings at f7 and g8" do
        before do
          position = "6k1/5K2/8/8/8/1B6/8/8 b - - 0 1"
          real_board.restore_position(position)
          bishop.position = [5, 1]
        end

        it "returns correct diagonal squares up to edge of board" do
          expected_sqs = [[4, 0], [6, 0], [4, 2], [3, 3], [2, 4], [6, 2], [7, 3]].sort

          expect(bishop.possible_move_squares(real_board).sort).to eq(expected_sqs)
        end

        it "does not include the white king's square" do
          expect(bishop.possible_move_squares(real_board).include?([1, 5])).to eq(false)
        end
      end
    end

    context "when the piece is a white rook" do
      subject(:rook) { described_class.create(PieceType::ROOK, Color::WHITE) }

      context "when the rook is at position h1 with kings at h4 and h5 " do
        before do
          position = "8/8/8/7K/7k/8/8/7R b - - 0 1"
          real_board.restore_position(position)
          rook.position = [7, 7]
        end

        it "returns correct orthogonal squares up to edge of board or other pieces" do
          expected_sqs = [[7, 0], [7, 1], [7, 2], [7, 3], [7, 4], [7, 5], [7, 6], [4, 7], [5, 7], [6, 7]].sort

          expect(rook.possible_move_squares(real_board).sort).to eq(expected_sqs)
        end

        it "does not include the white king's square" do
          expect(rook.possible_move_squares(real_board).include?([3, 7])).to eq(false)
        end
      end
    end

    context "when the piece is a black queen" do
      subject(:queen) { described_class.create(PieceType::QUEEN, Color::BLACK) }

      context "when the queen is in an empty board at position e8" do
        before do
          position = "4q3/8/8/8/8/8/8/8 w - - 0 1"
          real_board.restore_position(position)
          queen.position = [0, 4]
        end

        it "returns correct diagonal and orthogonal squares up to edge of board" do
          expected_sqs = [[0, 0], [0, 1], [0, 2], [0, 3], [0, 5], [0, 6], [0, 7], [1, 4], [2, 4], [3, 4], [4, 4], [5, 4], [6, 4], [7, 4], [1, 3], [2, 2], [3, 1], [4, 0], [1, 5], [2, 6], [3, 7]].sort

          expect(queen.possible_move_squares(real_board).sort).to eq(expected_sqs)
        end
      end

      context "when the queen is at position e8 with kings at e6 and g6 " do
        before do
          position = "4q3/8/4K1k1/8/8/8/8/8 w - - 0 1"
          real_board.restore_position(position)
          queen.position = [0, 4]
        end

        it "returns correct diagonal and orthogonal squares up to edge of board" do
          expected_sqs = [[0, 0], [0, 1], [0, 2], [0, 3], [0, 5], [0, 6], [0, 7], [1, 4], [2, 4], [1, 3], [2, 2], [3, 1], [4, 0], [1, 5]].sort

          expect(queen.possible_move_squares(real_board).sort).to eq(expected_sqs)
        end

        it "does not include the black king's square" do
          expect(queen.possible_move_squares(real_board).include?([2, 6])).to eq(false)
        end

        it "includes the white king's square" do
          expect(queen.possible_move_squares(real_board).include?([2, 4])).to eq(true)
        end
      end
    end
  end

  describe "#threatened_squares" do
    let(:board) { double("board") }
    context "when board#within_bounds? always returns true" do
      before do
        allow(board).to receive(:within_bounds?).and_return(true)
      end

      context "when the piece is a white pawn" do
        subject(:white_pawn) { described_class.create(PieceType::PAWN, Color::WHITE) }
        context "when it is on a2" do
          it "returns [[5, -1], [5, 1]]" do
            white_pawn.position = [6, 0]
            expect(white_pawn.threatened_squares(board)).to eq([[5, -1], [5, 1]])
          end
        end

        context "when it is on a3" do
        it "returns [[4, -1], [4, 1]]" do
            white_pawn.position = [5, 0]
            expect(white_pawn.threatened_squares(board)).to eq([[4, -1], [4, 1]])
          end
        end
      end

      context "when the piece is a black pawn" do
        subject(:black_pawn) { described_class.create(PieceType::PAWN, Color::BLACK) }
        context "when it is on b2" do
          it "returns [[7, 0], [7, 2]]" do
            black_pawn.position = [6, 1]
            expect(black_pawn.threatened_squares(board)).to eq([[7, 0], [7, 2]])
          end
        end

        context "when it is on b7" do
          it "returns [[2, 0], [2, 2]]" do
            black_pawn.position = [1, 1]
            expect(black_pawn.threatened_squares(board)).to eq([[2, 0], [2, 2]])
          end
        end
      end

      context "when the piece is a knight" do
        subject(:knight) { described_class.create(PieceType::KNIGHT, Color::BLACK) }
        context "when it is on d4" do
          it "returns [[2, 2], [2, 4], [3, 5], [5, 5], [6, 4], [6, 2], [5, 1], [3, 1]]" do
            knight.position = [4, 3]
            expect(knight.threatened_squares(board).sort).to eq([[2, 2], [2, 4], [3, 5], [5, 5], [6, 4], [6, 2], [5, 1], [3, 1]].sort)
          end
        end
      end
    end

    context "when the piece is a bishop" do
      subject(:bishop) { described_class.create(PieceType::BISHOP, Color::WHITE) }
      let(:real_board) { Board.new }

      context "when the bishop is in an empty board at position b3" do
        before do
          position = "8/8/8/8/8/1B6/8/8 w - - 0 1"
          real_board.restore_position(position)
          bishop.position = [5, 1]
        end

        it "returns correct diagonal squares up to edge of board" do
          expected_sqs = [[4, 0], [6, 0], [4, 2], [3, 3], [2, 4], [1, 5], [0, 6], [6, 2], [7, 3]].sort

          expect(bishop.threatened_squares(real_board).sort).to eq(expected_sqs)
        end
      end

      context "when the bishop is at position b3 with kings at d1 and d5" do
        before do
          position = "8/8/8/3K4/8/1B6/8/3k4 w - - 0 1"
          real_board.restore_position(position)
          bishop.position = [5, 1]
        end

        it "returns correct diagonal squares up to edge of board and other pieces" do
          expected_sqs = [[4, 0], [6, 0], [4, 2], [3, 3], [6, 2], [7, 3]].sort

          expect(bishop.threatened_squares(real_board).sort).to eq(expected_sqs)
        end
      end
    end

    context "when the piece is a rook" do
      subject(:rook) { described_class.create(PieceType::ROOK, Color::WHITE) }
      let(:real_board) { Board.new }

      context "when the rook is at position h1 with kings at h4 and h5 " do
        before do
          position = "8/8/8/7K/7k/8/8/7R b - - 0 1"
          real_board.restore_position(position)
          rook.position = [7, 7]
        end

        it "returns correct orthogonal squares up to edge of board or other pieces" do
          expected_sqs = [[7, 0], [7, 1], [7, 2], [7, 3], [7, 4], [7, 5], [7, 6], [4, 7], [5, 7], [6, 7]].sort

          expect(rook.threatened_squares(real_board).sort).to eq(expected_sqs)
        end
      end
    end

    context "when the piece is a queen" do
      subject(:queen) { described_class.create(PieceType::QUEEN, Color::BLACK) }
      let(:real_board) { Board.new }

      context "when the queen is in an empty board at position e8" do
        before do
          position = "4q3/8/8/8/8/8/8/8 w - - 0 1"
          real_board.restore_position(position)
          queen.position = [0, 4]
        end

        it "returns correct diagonal and orthogonal squares up to edge of board" do
          expected_sqs = [[0, 0], [0, 1], [0, 2], [0, 3], [0, 5], [0, 6], [0, 7], [1, 4], [2, 4], [3, 4], [4, 4], [5, 4], [6, 4], [7, 4], [1, 3], [2, 2], [3, 1], [4, 0], [1, 5], [2, 6], [3, 7]].sort

          expect(queen.threatened_squares(real_board).sort).to eq(expected_sqs)
        end
      end

      context "when the queen is at position e8 with kings at e6 and g6 " do
        before do
          position = "4q3/8/4K1k1/8/8/8/8/8 w - - 0 1"
          real_board.restore_position(position)
          queen.position = [0, 4]
        end

        it "returns correct diagonal and orthogonal squares up to edge of board or other pieces" do
          expected_sqs = [[0, 0], [0, 1], [0, 2], [0, 3], [0, 5], [0, 6], [0, 7], [1, 4], [2, 4], [1, 3], [2, 2], [3, 1], [4, 0], [1, 5], [2, 6]].sort

          expect(queen.threatened_squares(real_board).sort).to eq(expected_sqs)
        end
      end
    end
  end
end
