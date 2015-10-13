require_relative 'notification_record'

class SlackNotifier
  DEFAULT_USERNAME = 'mechacoach'
  attr_reader :client, :channel, :username

  def initialize(client_class: Slack::Notifier, team: 'makersacademy', channel: '#coaches')
    @username = DEFAULT_USERNAME
    @channel = channel
    @client = client_class.new(ENV["SLACK_WEBHOOK_URL_#{team}"], config(channel))
  end

  def notify(message = default_message)
    notification = { channel: channel, message: message }
    if client.ping(message)
      NotificationRecord.store(notification)
      :notified
    end
  end

  private

  def config(channel)
    {
      channel:  channel,
      username: username,
      icon_emoji: ':tophat:'
    }
  end

  def default_message
    'Fear me! I am Mechacoach!'
  end
end