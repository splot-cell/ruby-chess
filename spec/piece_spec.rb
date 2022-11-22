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
end
