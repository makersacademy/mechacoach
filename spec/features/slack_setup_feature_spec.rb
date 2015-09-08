require 'mechacoach'

describe 'setting up Slack integration' do
  let(:coach) { Mechacoach.new }

  it 'notifies Slack' do
    expect(coach.notifier).to be_a Slack::Notifier
  end

  it 'sets up Slack integration with a channel' do
    expect(coach.notifier.default_payload[:channel]).to eq '#coaches'
  end

  it 'sets up Slack integration with a username' do
    expect(coach.notifier.default_payload[:username]).to eq 'mechacoach'
  end
end