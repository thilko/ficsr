require "spec_helper"

Ficsr::Session.username = ENV["ficsr_username"]
Ficsr::Session.password = ENV["ficsr_password"]

describe Ficsr::Session do
  describe ".login" do
    context "with valid credentials" do
      it "performs a successful login" do
        Ficsr::Session.instance.login
      end
    end

    context "with invalid credentials" do
      it "does not login" do
        expect do
          Ficsr::Session.instance.login
        end.to raise_error
      end
    end

    context "with an anonymous user" do
      it "does a login" do
        Ficsr::Session.instance.login
      end
    end
  end

  let(:session) do
    session = Ficsr::Session.instance
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
