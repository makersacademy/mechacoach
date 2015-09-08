require 'mechacoach'

describe Mechacoach do
  subject { Mechacoach.new }

  context 'communicating with Slack' do
    it 'notifies Slack' do
      expect(subject.notifier).to be_a Slack::Notifier
    end

    it 'sets up Slack integration with a channel' do
      expect(subject.notifier.default_payload[:channel]).to eq '#coaches'
    end

    it 'sets up Slack integration with a username' do
      expect(subject.notifier.default_payload[:username]).to eq 'mechacoach'
    end
  end

  context 'being fearsome' do
    it 'makes fearsome comments' do
      expect(subject.be_fearsome).to eq 'Fear me! I am Mechacoach!'
    end
  end
end