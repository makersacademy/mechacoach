require 'mechacoach'

describe 'setting up Slack integration' do
  let(:github_client) { double :github_client }
  let(:github_wrapper) { double :github_klass, { new: github_client } }

  let(:coach) do
    Mechacoach.new(github_wrapper)
  end

  it 'sets up Slack integration with a channel' do
    expect(coach.slack_client.default_payload[:channel]).to eq '#coaches'
  end

  it 'sets up Slack integration with a username' do
    expect(coach.slack_client.default_payload[:username]).to eq 'mechacoach'
  end
end