require_relative "../../lib/pieces/king"
require_relative "../../lib/board"

describe King do
  subject(:king) { described_class.new(PieceType::KING, Color::WHITE, [0, 0]) }
  describe "#moves" do
    let(:board) { Board.new }
    context "when the king is at e3" do
      before do
        king.position = [5, 4]
      end

      context "when the board is otherwise empty" do
        before do
          board.restore_position("8/8/8/8/8/4K3/8/8 w - - 0 1")
        end

        it "returns 8 moves" do
          expect(king.moves(board).length).to eq(8)
        end
      end

      context "when an enemy piece can be taken" do
        before do
          board.restore_position("8/8/8/8/5p2/4K3/8/8 w - - 0 1")
        end

        it "returns 8 moves" do
          expect(king.moves(board).length).to eq(8)
        end
      end

      context "when a friendly piece is blocking an adjacent square" do
        before do
          board.restore_position("8/8/8/8/5P2/4K3/8/8 w - - 0 1")
        end

        it "requrns 7 moves" do
          expect(king.moves(board).length).to eq(7)
        end
      end
    end

    context "when the king is in its starting position" do
    end
  end
end
