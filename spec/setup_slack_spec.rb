require 'setup_slack'

describe SetupSlack do
  let(:slack_client) { double :slack_client, { default_payload: {channel: '#coaches', username: 'mechacoach'} } }
  let(:slack_wrapper) { double :slack_klass, { new: slack_client } }


  describe '.with' do
    it 'accepts a Slack Notifier' do
      expect(described_class).to respond_to(:with).with(1).argument
    end

    before do
      @result = described_class.with(slack_wrapper)
    end

    it 'sets up Slack integration with a channel' do
      expect(@result.default_payload[:channel]).to eq '#coaches'
    end

    it 'sets up Slack integration with a username' do
      expect(@result.default_payload[:username]).to eq 'mechacoach'
    end
  end
end