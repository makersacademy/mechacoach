require 'slack-notifier'

class Mechacoach
  attr_reader :notifier

  def initialize
    @notifier = setup_notifier
  end

  def be_fearsome
    'Fear me! I am Mechacoach!'
  end

  private

  def setup_notifier
    Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL'], 
      {
        channel:  '#coaches',
        username: 'mechacoach'
      }
    )
  end
end