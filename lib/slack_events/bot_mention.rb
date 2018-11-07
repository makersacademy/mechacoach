class BotMention
  DEFAULT_CHANNEL = '#coaches'
  TIME_FORMAT = "%A %I:%M%P"

  def initialize(team, event)
    @team = team
    @event = event
  end

  def run
    SlackNotifier.new(team: team, channel: DEFAULT_CHANNEL).notify(message)
  end

  private

  attr_reader :team, :event

  def message
    [
      "<!channel>",
      "At #{time} in <##{event['channel']}>, <@#{event['user']}> said: ",
      "#{event['text']}",
    ].join("\n")
  end

  def time
    Time.at(event['event_ts'].to_f).strftime(TIME_FORMAT)
  end
end
