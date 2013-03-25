require 'spec_helper'

describe "Messages" do
  describe "GET /messages" do
    it "renders the main application page" do
      get messages_path
      response.status.should be(200)
    end
  end

  describe "POST /messages" do
    context 'when not signed in' do
      it "returns not authorized" do
        PUBLISHER.stub(:publish)
        PUBLISHER.should_not_receive(:publish)
        post messages_path
        response.status.should be(401)
      end
    end

    context 'when signed in' do
      it 'posts a message to faye' do
        pending 'figure out why this cannot log in'
        PUBLISHER.stub(:publish)
        PUBLISHER.should_receive(:publish)
        login_with :twitter, 'uid' => '123456', 'info' => { 'nickname' => 'tester' }
        puts OmniAuth.config.mock_auth[:twitter]
        post messages_path
        response.status.should be(200)
      end
    end
  end
end
