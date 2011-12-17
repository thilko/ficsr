require "spec_helper"

describe Ficsr::Session do
  describe ".login" do
    context "with valid credentials" do
      before do
        Ficsr::Session.username = ENV["ficsr_username"]
        Ficsr::Session.password = ENV["ficsr_password"]
      end

      it "performs a successful login" do
        Ficsr::Session.new.login
      end
    end

    context "with invalid credentials" do
      before do
        Ficsr::Session.username = "wrong"
        Ficsr::Session.password = "wrong"
      end

      it "does not login" do
        expect do
          Ficsr::Session.new.login
        end.to raise_error
      end
    end

    context "with an anonymous user" do
      before do
        Ficsr::Session.username = ENV["ficsr_username"]
        Ficsr::Session.password = ENV["ficsr_password"]
      end

      it "does a login" do
        Ficsr::Session.new.login
      end
    end
  end

  let(:session) do
    session = Ficsr::Session.new
    session.login
    session
  end

  describe "#games" do
    it "returns a list of games" do
      session.games.each { |game| game.should be_a Ficsr::Game }
    end
  end

  describe "#observe" do
    let(:game_number) { session.games.first.number }
    it "starts observing the game" do
      session.observe game_number do |move|
        p "MOVE: #{move}"
      end
    end
  end

end
