require 'mechacoach'

describe 'Making Slack notifications' do
  let(:coach) { Mechacoach.new }
  it 'makes Slack notifications' do
    allow_any_instance_of(Slack::Notifier).to receive(:ping).and_return(true)
    expect(coach.notify(:be_fearsome)).to be true
  end
end