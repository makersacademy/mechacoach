require 'setup_github'

describe SetupGithub do
  let(:github_client) { double :github_client, { login: 'mechacoach' } }
  let(:github_wrapper) { double :github_klass, { new: github_client } }

  describe '.with' do
    it 'accepts a GitHub Wrapper' do
      expect(described_class).to respond_to(:with).with(1).argument
    end

    before do
      @result = described_class.with(github_wrapper)
    end

    it 'authenticates with GitHub' do
      expect(@result.login).to eq 'mechacoach'
    end
  end
end