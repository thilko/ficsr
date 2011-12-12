require "spec_helper"

describe Ficsr::Session do

  Ficsr::Session.username = "test_user"
  Ficsr::Session.password = "test_password"

  describe ".instance" do
    context "with a successful login" do
      before do
        mocked_session = Ficsr::Session.new
        mocked_session.expects(:do_login)
        Ficsr::Session.expects(:new).returns(mocked_session)
      end

      it "returns a session object" do
        Ficsr::Session.instance.should be_a Ficsr::Session
      end
    end
  end
end
