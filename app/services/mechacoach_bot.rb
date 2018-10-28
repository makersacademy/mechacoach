require_relative '../../lib/slack_events/bot_mention'

class MechacoachBot
  TEAMS = {
    'T03ALA7H4' => 'makersstudents'
  }
  EVENTS = {
    'app_mention' => BotMention
  }

  def self.process(team_id:, event: )
    team = TEAMS[team_id]
    event = EVENTS[event['type']].new(team, event)
    event.run
  end
end
