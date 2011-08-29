require "ficsr"

GAME = "302 1221 vinayakghol ++++ Bhuvi      [psr 15  20]  16:38 - 15:08 (37-39) W: 13"

describe Ficsr::Game do
  describe ".new" do
    it "creates a new game object from the given string"  do 
      Ficsr::Game.new(GAME).should be_a Ficsr::Game 
    end
  end

  let(:game) { Ficsr::Game.new GAME }

  describe "#number" do
    it "returns the number of the game " do
      game.number.should == 302
    end
  end

  describe "#white_handle" do
    it "returns the handle of the white player " do
      game.white_handle.should == "vinayakghol"
    end
  end

  describe "#white_rating" do
    it "returns the rating of the white player " do
      game.white_rating.should == "1221"
    end
  end
  describe "#black_handle" do
    it "returns the handle of the black player " do
      game.black_handle.should == "Bhuvi"
    end
  end

  describe "#black_rating" do
    it "returns the rating of the white player " do
      game.black_rating.should == "++++"
    end
  end

  describe "#private?" do
    it "returns true if the game is private" do
      game.should be_private
    end
  end

  describe "#category" do
    it "returns the category" do
      game.category.should == :standard
    end
  end

  describe "#rated?" do
    it "returns true for a rated game" do
      game.should be_rated
    end
  end

  describe "#start_minutes" do
    it "returns the minuted each player get at the beginning" do
      game.start_minutes.should == 15
    end
  end

  describe "#increment_seconds" do
    it "returns true for a rated game" do
      game.increment_seconds.should == 20
    end
  end

  describe "#time_white" do
    it "returns the remaining time of white" do
      game.time_white.should == "16:38"
    end
  end

  describe "#time_black" do
    it "returns the remaining time of black" do
      game.time_black.should == "15:08"
    end
  end

  describe "#strength_white" do
    it "returns the strength of white" do
      game.strength_white.should == 37
    end
  end

  describe "#strength_black" do
    it "returns the strength of black" do
      game.strength_black.should == 39
    end
  end

  describe "#whites_turn?" do
    it "return true if it is whites turn" do
      game.should be_whites_turn
    end
  end

  describe "#move_number" do
    it "return the current move number of white/black"  do
      game.move_number == 13
    end
  end
end
