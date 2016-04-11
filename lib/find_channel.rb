require_relative 'slack_notifier'

class FindChannel
  def self.with(channel)
    notifier = SlackNotifier.new({team: 'makersstudents', channel: slackified_channel(channel)})
    # If the channel does not exist, the error message is 'Invalid channel specified'
    notifier.notify('') != "Invalid channel specified"
  end

  private

  def self.slackified_channel(channel)
    "##{channel}"
  end
end
