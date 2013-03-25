require 'spec_helper'

describe Publisher do
  subject(:publisher) { Publisher.new }

  describe '#publish' do
    let(:client) { Object.new }
    let(:channel) { '/test' }
    let(:message) { 'Testing Chat' }

    it 'posts a message to faye' do
      client.stub(:publish)
      Faye::Client.stub(:new).and_return(client)
      client.should_receive(:publish).with(channel, message)
      publisher.publish(channel, message)
    end
  end
end