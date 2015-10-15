require 'slack-notifier'
require 'octokit'
require_relative 'slack_notifier'
require_relative 'setup_github'
require_relative 'pair_fetcher'
require_relative 'pair_tracker'
require_relative 'notification_record'

class Mechacoach
  attr_reader :slack_notifier, :github_client, :pair_fetcher, :pair_tracker

  def initialize(slack_notifier: SlackNotifier, github_klass: Octokit::Client, pair_fetcher: PairFetcher, pair_tracker: PairTracker)
    @slack_notifier = slack_notifier
    @github_client = SetupGithub.with(github_klass)
    @pair_fetcher = pair_fetcher
    @pair_tracker = pair_tracker
  end

  def slack_overflow_issue(issue_number)
    raise 'Authenticate with GitHub first' unless github_client
    raise 'You must pass an issue number' unless issue_number.is_a? Fixnum
    github_client.add_comment('makersacademy/slack-overflow', issue_number, slack_overflow_formatting_info)
  end

  def output_pairs(cohort)
    if pairs_for_today(cohort)
      slack_notifier.new({
        team: 'makersstudents',
        channel: "##{cohort}"
      }).notify(pairs_for_today(cohort))
      pair_tracker.increment(cohort)
      :notified
    else
      slack_notifier.new.notify(out_of_pairs(cohort))
    end
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

  def pairs_for_today(cohort)
    pair_fetcher.call(cohort)[pair_tracker.index(cohort)]
  end

  def out_of_pairs(cohort)
    "I'm out of pairs for #{cohort.capitalize}. Fix me!"
  end
end