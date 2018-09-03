require_relative 'slack_notifier'

class FindChannel
  TEST_MESSAGE = ''.freeze

  def self.with(team, channel)
    begin
      SlackNotifier
        .new({ team: team, channel: slackified_channel(channel) })
        .notify(TEST_MESSAGE)
    rescue URI::InvalidURIError => response
      team_exists?(response)
    rescue SlackNotifications::SlackNotificationError => response
      channel_exists?(response)
    end
  end

  private

  def self.slackified_channel(channel)
    "##{channel}"
  end

  def self.team_exists?(response)
    false
  end

  def self.channel_exists?(response)
    response.code == '500'
  end
end
