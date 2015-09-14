require 'slack-notifier'
require 'octokit'

class Mechacoach
  attr_reader :slack_client, :github_client

  def initialize(github_klass = Octokit::Client, slack_klass = Slack::Notifier)
    @slack_client = setup_slack(slack_klass)
    @github_client = setup_github(github_klass)
  end

  def notify(method = :be_fearsome)
    notification = self.send(method)
    slack_client.ping(notification, icon_emoji: ':tophat:')
  end

  def slack_overflow_issue(issue_number)
    raise 'Authenticate with GitHub first' unless github_client
    raise 'You must pass an issue number' unless issue_number.is_a? Fixnum
    github_client.add_comment('makersacademy/slack-overflow', issue_number, slack_overflow_formatting_info)
  end

  def be_fearsome
    'Fear me! I am Mechacoach!'
  end

  private

  def setup_slack(slack_klass)
    slack_klass.new(ENV['SLACK_WEBHOOK_URL'], slack_config_hash)
  end

  def setup_github(github_klass)
    github_klass.new(github_auth_hash)
  end

  def slack_config_hash
    {
      channel:  '#coaches',
      username: 'mechacoach'
    }
  end

  def github_auth_hash
    {
      :login => ENV['GITHUB_USERNAME'], 
      :password => ENV['GITHUB_PASSWORD']
    }
  end

  def slack_overflow_formatting_info
    <<-eos
A word to the wise - format overflow questions like this:

1. What you're trying to do
2. The code to do it in a [GitHub-flavoured Markdown](https://help.github.com/articles/github-flavored-markdown/) code block
3. The error you're getting

That will help a casual browser to quickly point you in the right direction.
    eos
  end
end