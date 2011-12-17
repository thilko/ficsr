require "spec_helper"

describe Ficsr::Session do

  Ficsr::Session.username = "test_user"
  Ficsr::Session.password = "test_password"

  describe "#login" do
    context "with a successful login" do
      it "returns a session object" do
        subject.login
      end
    end
  end
end
