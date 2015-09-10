require 'mechacoach'

describe 'being fearsome' do
  let(:github_client) { double :github_client }
  let(:github_wrapper) { double :github_klass, { new: github_client } }

  let(:coach) do
    Mechacoach.new(github_wrapper)
  end

  it 'Mechacoach lets us know how terrifying it is' do
    expect(coach.be_fearsome).to eq 'Fear me! I am Mechacoach!'
  end
end