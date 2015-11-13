require 'slack-notifier'
require 'octokit'
require_relative 'slack_notifier'
require_relative 'setup_github'
require_relative 'notification_record'

class Mechacoach
  attr_reader :slack_notifier, :github_client, :pair_fetcher, :pair_tracker

  def initialize(slack_notifier: SlackNotifier, github_klass: Octokit::Client)
    @slack_notifier = slack_notifier
    @github_client = SetupGithub.with(github_klass)
  end

  def slack_overflow_issue(issue_number)
    raise 'Authenticate with GitHub first' unless github_client
    raise 'You must pass an issue number' unless issue_number.is_a? Fixnum
    github_client.add_comment('makersacademy/slack-overflow', issue_number, slack_overflow_formatting_info)
  end

  private

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
