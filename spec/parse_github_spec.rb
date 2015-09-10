require 'parse_github'

describe ParseGithub do
  describe '.with' do
    it 'receives payloads from GitHub' do
      expect(described_class).to respond_to(:with).with(1).argument
    end
  end
end