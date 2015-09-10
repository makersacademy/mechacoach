require 'mechacoach'

describe Mechacoach do
  context 'communicating with Slack' do
    let(:github_client) { double :github_client }
    let(:github_wrapper) { double :github_klass, { new: github_client } }

    subject do
      Mechacoach.new(github_wrapper)
    end

    it 'notifies Slack' do
      expect(subject.notifier).to be_a Slack::Notifier
    end

    it 'sets up Slack integration with a channel' do
      expect(subject.notifier.default_payload[:channel]).to eq '#coaches'
    end

    it 'sets up Slack integration with a username' do
      expect(subject.notifier.default_payload[:username]).to eq 'mechacoach'
    end

    it 'makes Slack notifications' do
      allow_any_instance_of(Slack::Notifier).to receive(:ping).and_return(true)
      expect(subject.notify(:be_fearsome)).to be true
    end
  end

  context 'communicating with Slack Overflow' do
    subject { Mechacoach.new }

    before do
      allow_any_instance_of(Octokit::Client).to receive(:add_comment).and_return({})
    end

    it 'authenticates with GitHub' do
      expect(subject.github_client).not_to be_nil
    end

    it 'replies to a specific Slack Overflow issue' do
      expect{ subject.slack_overflow_issue(92) }.not_to raise_error
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
end