require 'notification_record'

describe NotificationRecord do
  let(:redis) { Redis.new }
  let(:notification) { { "channel" => '#coaches', "notification" => 'Fear me! I am Mechacoach!' } }

  describe '.store' do
    it 'stores a notification' do
      described_class.store(notification)
      expect(JSON.parse(redis.lrange('notifications', 0, 0)[0])).to eq notification
    end
  end

  describe '.retrieve_last' do
    before do
      redis.lpush("notifications", notification.to_json)
    end

    it 'retrieves the last stored notification' do
      expect(described_class.retrieve_last).to eq notification
    end
  end
end