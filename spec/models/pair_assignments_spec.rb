describe PairAssignments do
  let(:assignments_source) { [
    [['jon', 'andrew'], ['bob', 'phil']],
    [['jon', 'phil'], ['bob', 'andrew']],
    [['jon', 'bob'], ['andrew', 'phil']]
  ] }

  let(:assignments_json) { assignments_source.to_json }
  let(:repo) { double :repo, get: assignments_json }

  before do
    allow(PairAssignments).to receive(:repo).and_return(repo)
  end

  subject(:assignments) { described_class.find(:test2015) }

  it 'fetches assignments from the repo' do
    expect(repo).to receive(:get).with("test2015_pairs")
    PairAssignments.find(:test2015)
  end

  it 'creates entries in the repo' do
    allow(repo).to receive(:set).with("test2015_index", 0)
    expect(repo).to receive(:set).with("test2015_pairs", assignments_json)
    PairAssignments.create(:test2015, assignments_source)
  end

  it 'returns nil if the cohort does not exist' do
    allow(repo).to receive(:get).and_return(nil)
    expect(PairAssignments.find(:junk)).not_to be
  end

  it 'knows which cohort it was initialized for' do
    expect(assignments.cohort).to eq :test2015
  end

  describe 'next' do
    before do
      allow(repo).to receive(:incr)
    end

    it 'gets the index from the repo' do
      expect(repo).to receive(:get).with('test2015_index')
      assignments.next
    end

    it 'returns the first assignment first' do
      allow(repo).to receive(:get).with('test2015_index').and_return(0)
      expect(assignments.next).to eq [['jon', 'andrew'], ['bob', 'phil']]
    end

    it 'increments the repo index' do
      expect(repo).to receive(:incr).with('test2015_index')
      assignments.next
    end

    it 'returns the second assignment second' do
      allow(repo).to receive(:get).with('test2015_index').and_return(1)
      expect(assignments.next).to eq [['jon', 'phil'], ['bob', 'andrew']]
    end

    it 'cycles when reaching the last assignment' do
      allow(repo).to receive(:get).with('test2015_index').and_return(2, 3)
      assignments.next
      expect(assignments.next).to eq [['jon', 'andrew'], ['bob', 'phil']]
    end
  end
end
