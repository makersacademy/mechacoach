require 'mechacoach'
require 'notification_record'

describe 'Making Slack notifications' do
  let(:slack_client) { double :slack_client, { ping: true } }
  let(:slack_client_class) { double :slack_client_class, { new: slack_client } }

  let(:notifier) do
    SlackNotifier.new({
      client_class: slack_client_class
    })
  end

  let(:notification_record) { NotificationRecord }

  it 'makes Slack notifications' do
    expect(notifier.notify).to eq :notified
  end

  it 'remembers the last Slack communiqué' do
    expected_notification = { "channel" => '#coaches', "message" => 'Fear me! I am Mechacoach!' }
    
    notifier.notify
    expect(notification_record.retrieve_last).to eq expected_notification
  end
end