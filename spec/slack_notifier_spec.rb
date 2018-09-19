require 'slack_notifier'
require 'net/http'
require 'redis'

describe SlackNotifier do
  let(:slack_client) { double :slack_client }
  let(:slack_client_class) { double :slack_client_class, { new: slack_client } }
  subject { described_class.new(client_class: slack_client_class) }

  context 'defaults' do
    before do
      allow(slack_client).to receive(:ping).and_return(true)
    end

    it 'uses the provided Slack client' do
      expect(subject.client).to eq slack_client
    end

    it 'defaults to the #testing channel' do
      expect(subject.channel).to eq '#testing'
    end

    it 'defaults to mechacoach username' do
      expect(subject.username).to eq 'mechacoach'
    end
  end

  describe '#notify' do
    before do
      allow(slack_client).to receive(:ping).and_return(response)
    end

    context 'well-formed notification (channel and message)' do
      let(:response) { double :http_response, { code: '200' }}

      it 'sends the notification' do
        expect(subject.notify).to eq :notified
      end

      it 'stores the notification in a db' do
        subject.notify
        redis = Redis.new
        expect(JSON.parse(redis.lrange('notifications', 0, 0)[0])["message"]).to eq 'Fear me! I am Mechacoach!'
      end
    end

    context 'poorly-formed notification (channel does not exist)' do
      let(:response) { double :http_resource_not_found, { code: '404', body: 'Channel not found' }}

      it 'throws ChannelNotFoundError' do
        expect { subject.notify }.to raise_error '404: Channel not found'
      end
    end

    context 'poorly-formed notification (message empty)' do
      let(:response) { double :http_internal_server_error, { code: '400', body: 'No text specified' }}

      it 'throws NoTextError ' do
        expect { subject.notify }.to raise_error '400: No text specified'
      end
    end

    context 'notification returns new error' do
      let(:response) { double :http_internal_server_error, { code: '302', body: 'another error' }}

      it 'throws default error ' do
        expect { subject.notify }.to raise_error "Please update slack_notifier in /lib with this error: 302: another error"
      end
    end
  end
end
