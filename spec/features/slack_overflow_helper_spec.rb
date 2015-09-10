require 'mechacoach'

describe 'posting to Slack Overflow' do
  let(:coach) { Mechacoach.new }
  context 'when a new Slack Overflow issue is created' do
    it 'posts formatting information for that question' do
      # hit the webhook
      coach = Mechacoach.new
      expect(coach.slack_overflow_issue(92)[:body]).to eq slack_overflow_formatting_info
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
end