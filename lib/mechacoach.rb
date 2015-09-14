require 'slack-notifier'
require 'octokit'

class Mechacoach
  attr_reader :slack_client, :github_client

  def initialize(github_klass: Octokit::Client, slack_klass: Slack::Notifier)
    @slack_client = SetupSlack.with(slack_klass)
    @github_client = SetupGithub.with(github_klass)
  end

  def notify_slack(method = :be_fearsome)
    notification = self.send(method)
    slack_client.ping(notification, icon_emoji: ':tophat:')
  end

  def slack_overflow_issue(issue_number)
    raise 'Authenticate with GitHub first' unless github_client
    raise 'You must pass an issue number' unless issue_number.is_a? Fixnum
    github_client.add_comment('makersacademy/slack-overflow', issue_number, slack_overflow_formatting_info)
  end

  private

  def be_fearsome
    'Fear me! I am Mechacoach!'
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