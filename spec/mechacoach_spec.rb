require 'mechacoach'

describe Mechacoach do
  context 'communicating with GitHub' do
    let(:github_client) { double :github_client, { add_comment: {} } }
    let(:github_wrapper) { double :github_klass, { new: github_client } }

    subject do
      Mechacoach.new(github_klass: github_wrapper)
    end

    it 'authenticates with GitHub' do
      expect(subject.github_client).to eq github_client
    end

    it 'replies to a specific GitHub issue' do
      expect { subject.slack_overflow_issue(test_slack_overflow_issue_number) }.not_to raise_error
    end

    it 'raises an error if passed malformed data' do
      expect { subject.slack_overflow_issue(nil) }.to raise_error 'You must pass an issue number'
    end
  end

  private

  def test_slack_overflow_issue_number
    95
  end
end
