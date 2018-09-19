require 'find_channel'

describe FindChannel do
  describe '.with' do
    context 'channel exists in Slack' do
      it 'returns :ok' do
        VCR.use_cassette('existing_channel') do
          expect(described_class.with(existing_team, existing_channel)).to be :ok
        end
      end
    end

    context 'channel does not exist in Slack' do
      it 'returns :wrong_channel' do
        VCR.use_cassette('not_existing_channel') do
          expect(described_class.with(existing_team, non_existent_channel)).to be :wrong_channel
        end
      end
    end

    context 'Slack team does not exist' do
      it 'returns :wrong_team' do
        VCR.use_cassette('not_existing_team') do
          expect(described_class.with(non_existent_team, existing_channel)).to be :wrong_team
        end
      end
    end

    context 'Slack team nor channel exists' do
      it 'returns :wrong_team' do
        VCR.use_cassette('not_existing_team_or_channel') do
          expect(described_class.with(non_existent_team, non_existent_channel)).to be :wrong_team
        end
      end
    end
  end

  private

  def existing_channel
    'testing'
  end

  def existing_team
    'makersstudents'
  end

  def non_existent_channel
    'october 2015'
  end

  def non_existent_team
    'splufdoofthethird'
  end
end
