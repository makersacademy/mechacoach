require 'mechacoach'
require 'notification_record'

describe 'Making Slack notifications' do
  let(:response) { double :http_response, { code: '200' } }
  let(:slack_client) { double :slack_client, { ping: response } }
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
    expected_notification = { "channel" => '#testing', "message" => 'Fear me! I am Mechacoach!' }
    
    notifier.notify
    expect(notification_record.retrieve_last).to eq expected_notification
  end
end