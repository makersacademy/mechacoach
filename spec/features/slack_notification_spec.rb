require 'mechacoach'

describe 'Making Slack notifications' do
  let(:github_client) { double :github_client }
  let(:github_wrapper) { double :github_klass, { new: github_client } }

  let(:coach) do
    Mechacoach.new(github_klass: github_wrapper)
  end

  it 'makes Slack notifications' do
    allow_any_instance_of(Slack::Notifier).to receive(:ping).and_return(true)
    expect(coach.notify_slack(:be_fearsome)).to be true
  end
end