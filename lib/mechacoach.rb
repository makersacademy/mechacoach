require 'slack-notifier'

class Mechacoach
  attr_reader :notifier

  def initialize
    @notifier = setup_notifier
  end

  private

  def setup_notifier
    Slack::Notifier.new("WEBHOOK_URL", 
      {
        channel:  '#coaches',
        username: 'mechacoach'
      }
    )
  end
end