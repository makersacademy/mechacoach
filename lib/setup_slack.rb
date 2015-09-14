class SetupSlack
  def self.with(slack_klass)
    slack_klass.new(ENV['SLACK_WEBHOOK_URL'], slack_config_hash)
  end

  private

  def self.slack_config_hash
    {
      channel:  '#coaches',
      username: 'mechacoach'
    }
  end
end