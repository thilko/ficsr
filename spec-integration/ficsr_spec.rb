require "ficsr"

describe Ficsr::Session do
  describe ".login" do
    context "with valid credentials" do
      it "performs a successful login" do
        @session = Ficsr::Session.login ENV["ficsr_username"], ENV["ficsr_password"]
        @session.should_not be_nil
      end
    end

    context "with invalid credentials" do
      it "does not login" do
        expect { Ficsr::Session.login "blackhacker", "xxx" }.to
          raise_error
      end
    end
    
    context "with an anonymous user" do
      it "does a login" do
        @session = Ficsr::Session.login "someanonymous"
        @session.should_not be_nil
      end
    end
  end

  let(:session) { Ficsr::Session.login ENV["ficsr_username"], ENV["ficsr_password"] }
  
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
