require_relative 'notification_record'
require_relative 'slack_notification_errors'

class SlackNotifier
  def self.notify(message)
  end

  DEFAULT_USERNAME = 'mechacoach'
  ERRORS = {
    '404' => SlackNotifications::ChannelNotFoundError,
    '500' => SlackNotifications::NoTextError
  }

  attr_reader :client, :channel, :username

  def initialize(client_class: Slack::Notifier, team: 'makersacademy', channel: '#testing')
    @username = DEFAULT_USERNAME
    @channel = channel
    @client = client_class.new(ENV["SLACK_WEBHOOK_URL_#{team}"], config(channel))
  end

  def notify(message = default_message)
    res = client.ping(message)

    raise error(res.code, res.body) unless res.code == '200'

    notification = { channel: channel, message: message }
    NotificationRecord.store(notification)

    :notified
  end

  private

  def error(code, msg)
    ERRORS.fetch(code, SlackNotifications::DefaultError).new(code, msg)
  end

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
