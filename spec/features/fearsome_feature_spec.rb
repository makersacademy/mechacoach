require 'mechacoach'

describe 'being fearsome' do
  let(:coach) { Mechacoach.new }

  it 'Mechacoach lets us know how terrifying it is' do
    expect(coach.be_fearsome).to eq 'Fear me! I am Mechacoach!'
  end
end