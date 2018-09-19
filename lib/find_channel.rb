require_relative 'slack_notifier'

class FindChannel
  TEST_MESSAGE = ''.freeze

  def self.with(team, channel)
    begin
      SlackNotifier
        .new({ team: team, channel: slackified_channel(channel) })
        .notify(TEST_MESSAGE)
    rescue SlackNotifications::DefaultError
      :server_error
    rescue URI::InvalidURIError
      :wrong_team
    rescue SlackNotifications::ChannelNotFoundError
      :wrong_channel
    rescue SlackNotifications::NoTextError
      :ok
    end
  end

  private

  def self.slackified_channel(channel)
    "##{channel}"
  end
end
