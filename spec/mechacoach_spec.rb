require 'mechacoach'

describe Mechacoach do
  context 'communicating with Slack' do
    let(:github_client) { double :github_client }
    let(:github_wrapper) { double :github_klass, { new: github_client } }
    let(:slack_client) { double :slack_client }
    let(:slack_wrapper) { double :slack_klass, { new: slack_client } }

    subject do
      Mechacoach.new(github_wrapper, slack_wrapper)
    end

    it 'notifies Slack' do
      expect(subject.slack_client).to eq slack_client
    end

    it 'makes Slack notifications' do
      allow(slack_client).to receive(:ping).and_return(true)
      expect(subject.notify(:be_fearsome)).to be true
    end
  end

  context 'communicating with GitHub' do
    let(:github_client) { double :github_client, { add_comment: {} } }
    let(:github_wrapper) { double :github_klass, { new: github_client } }
    let(:slack_client) { double :slack_client }
    let(:slack_wrapper) { double :slack_klass, { new: slack_client } }

    subject do
      Mechacoach.new(github_wrapper, slack_wrapper)
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

  context 'being fearsome' do
    let(:github_client) { double :github_client }
    let(:github_wrapper) { double :github_klass, { new: github_client } }

    subject do
      Mechacoach.new(github_wrapper)
    end

    it 'makes fearsome comments' do
      expect(subject.be_fearsome).to eq 'Fear me! I am Mechacoach!'
    end
  end

  private

  def test_slack_overflow_issue_number
    95
  end
end