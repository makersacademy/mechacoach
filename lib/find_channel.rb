require_relative 'slack_notifier'

class FindChannel
  def self.with(channel)
    notifier = SlackNotifier.new({team: 'makersstudents', channel: slackified_channel(channel)})

    # This relies on SlackNotifier to first check if channel exists, and then to check if message is empty

    begin
      notifier.notify('')
    rescue SlackNotifications::SlackNotificationError => e
      return true if e.code == '500'
      return false if e.code == '404'
    end
  end

  private

  def self.slackified_channel(channel)
    "##{channel}"
  end
end
