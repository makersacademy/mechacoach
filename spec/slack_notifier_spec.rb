require 'slack_notifier'
require 'redis'

describe SlackNotifier do
  let(:slack_client) { double :slack_client, { ping: true } }
  let(:slack_client_class) { double :slack_client_class, { new: slack_client } }
  subject { described_class.new(client_class: slack_client_class) }

  context 'defaults' do
    it 'uses the provided Slack client' do
      expect(subject.client).to eq slack_client
    end

    it 'defaults to the #coaches channel' do
      expect(subject.channel).to eq '#coaches'
    end

    it 'defaults to mechacoach username' do
      expect(subject.username).to eq 'mechacoach'
    end
  end

  describe '#notify' do
    it 'sends the notification' do
      expect(subject.notify).to eq :notified
    end

    it 'stores the notification in a db' do
      subject.notify
      redis = Redis.new
      expect(JSON.parse(redis.lrange('notifications', 0, 0)[0])["message"]).to eq 'Fear me! I am Mechacoach!'
    end
  end
end