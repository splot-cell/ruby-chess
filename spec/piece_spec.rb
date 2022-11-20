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
    context "when no type is given" do
      it "returns a Piece object" do
        expect(Piece.create).to be_a(Piece)
      end

      it "returns a Piece object of type NONE" do
        expect(Piece.create.type).to eq(PieceType::NONE)
      end

      it "returns a Piece object of color nil" do
        expect(Piece.create.color).to be(nil)
      end
    end

    context "when type is PAWN" do
      it "returns an object of type Pawn" do
        expect(Piece.create(PieceType::PAWN)).to be_a(Pawn)
      end

      it "returns a Piece object with type PAWN" do
        expect(Piece.create(PieceType::PAWN).type).to eq(PieceType::PAWN)
      end

      context "when the color is WHITE" do
        it "returns a Piece object of color WHITE" do
          expect(Piece.create(PieceType::PAWN, PieceColor::WHITE).color).to eq(PieceColor::WHITE)
        end
      end

      context "when the color is BLACK" do
        it "returns a Piece obejct of color BLACK" do
          expect(Piece.create(PieceType::PAWN, PieceColor::BLACK).color).to eq(PieceColor::BLACK)
        end
      end
    end

    context "when type is KNIGHT" do
      it "returns an object of type Knight" do
        expect(Piece.create(PieceType::KNIGHT)).to be_a(Knight)
      end

      it "returns a Piece object with type KNIGHT" do
        expect(Piece.create(PieceType::KNIGHT).type).to eq(PieceType::KNIGHT)
      end

      context "when the color is WHITE" do
        it "returns a Piece object of color WHITE" do
          expect(Piece.create(PieceType::KNIGHT, PieceColor::WHITE).color).to eq(PieceColor::WHITE)
        end
      end

      context "when the color is BLACK" do
        it "returns a Piece obejct of color BLACK" do
          expect(Piece.create(PieceType::KNIGHT, PieceColor::BLACK).color).to eq(PieceColor::BLACK)
        end
      end
    end

    context "when type is BISHOP" do
      it "returns an object of type Bishop" do
        expect(Piece.create(PieceType::BISHOP)).to be_a(Bishop)
      end

      it "returns a Piece object with type BISHOP" do
        expect(Piece.create(PieceType::BISHOP).type).to eq(PieceType::BISHOP)
      end

      context "when the color is WHITE" do
        it "returns a Piece object of color WHITE" do
          expect(Piece.create(PieceType::BISHOP, PieceColor::WHITE).color).to eq(PieceColor::WHITE)
        end
      end

      context "when the color is BLACK" do
        it "returns a Piece obejct of color BLACK" do
          expect(Piece.create(PieceType::BISHOP, PieceColor::BLACK).color).to eq(PieceColor::BLACK)
        end
      end
    end

    context "when type is ROOK" do
      it "returns an object of type Rook" do
        expect(Piece.create(PieceType::ROOK)).to be_a(Rook)
      end

      it "returns a Piece object with type ROOK" do
        expect(Piece.create(PieceType::ROOK).type).to eq(PieceType::ROOK)
      end

      context "when the color is WHITE" do
        it "returns a Piece object of color WHITE" do
          expect(Piece.create(PieceType::ROOK, PieceColor::WHITE).color).to eq(PieceColor::WHITE)
        end
      end

      context "when the color is BLACK" do
        it "returns a Piece obejct of color BLACK" do
          expect(Piece.create(PieceType::ROOK, PieceColor::BLACK).color).to eq(PieceColor::BLACK)
        end
      end
    end

    context "when type is QUEEN" do
      it "returns an object of type Queen" do
        expect(Piece.create(PieceType::QUEEN)).to be_a(Queen)
      end

      it "returns a Piece object with type QUEEN" do
        expect(Piece.create(PieceType::QUEEN).type).to eq(PieceType::QUEEN)
      end

      context "when the color is WHITE" do
        it "returns a Piece object of color WHITE" do
          expect(Piece.create(PieceType::QUEEN, PieceColor::WHITE).color).to eq(PieceColor::WHITE)
        end
      end

      context "when the color is BLACK" do
        it "returns a Piece obejct of color BLACK" do
          expect(Piece.create(PieceType::QUEEN, PieceColor::BLACK).color).to eq(PieceColor::BLACK)
        end
      end
    end

    context "when type is KING" do
      it "returns an object of type King" do
        expect(Piece.create(PieceType::KING)).to be_a(King)
      end

      it "returns a Piece object with type KING" do
        expect(Piece.create(PieceType::KING).type).to eq(PieceType::KING)
      end

      context "when the color is WHITE" do
        it "returns a Piece object of color WHITE" do
          expect(Piece.create(PieceType::KING, PieceColor::WHITE).color).to eq(PieceColor::WHITE)
        end
      end

      context "when the color is BLACK" do
        it "returns a Piece obejct of color BLACK" do
          expect(Piece.create(PieceType::KING, PieceColor::BLACK).color).to eq(PieceColor::BLACK)
        end
      end
    end
  end

  describe "#to_s" do
    context "when the piece is of type NONE" do
      subject(:piece_none) { described_class.create }
      it "returns ' '" do
        expect(piece_none.to_s).to eq(" ")
      end
    end

    context "when the piece is a white king" do
      subject(:white_king) { described_class.create(PieceType::KING, PieceColor::WHITE) }
      it "returns ♔" do
        expect(white_king.to_s).to eq("♔")
      end
    end

    context "when the piece is a white queen" do
      subject(:white_queen) { described_class.create(PieceType::QUEEN, PieceColor::WHITE) }
      it "returns ♕" do
        expect(white_queen.to_s).to eq("♕")
      end
    end

    context "when the piece is a white rook" do
      subject(:white_rook) { described_class.create(PieceType::ROOK, PieceColor::WHITE) }
      it "returns ♖" do
        expect(white_rook.to_s).to eq("♖")
      end
    end

    context "when the piece is a white bishop" do
      subject(:white_bishop) { described_class.create(PieceType::BISHOP, PieceColor::WHITE) }
      it "returns ♗" do
        expect(white_bishop.to_s).to eq("♗")
      end
    end

    context "when the piece is a white knight" do
      subject(:white_knight) { described_class.create(PieceType::KNIGHT, PieceColor::WHITE) }
      it "returns ♘" do
        expect(white_knight.to_s).to eq("♘")
      end
    end

    context "when the piece is a white pawn" do
      subject(:white_pawn) { described_class.create(PieceType::PAWN, PieceColor::WHITE) }
      it "returns ♙" do
        expect(white_pawn.to_s).to eq("♙")
      end
    end
  end
end
