require 'find_channel'

describe FindChannel do
  describe '.with' do
    context 'channel exists in Slack' do
      it 'returns true' do
        expect(described_class.with(existing_channel)).to be true
      end
    end

    context 'channel does not exist in Slack' do
      it 'returns false' do
        expect(described_class.with(non_existent_channel)).to be false
      end
    end
  end

  private

  def existing_channel
    'october2015'
  end

  def non_existent_channel
    'october 2015'
  end
end