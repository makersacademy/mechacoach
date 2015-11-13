require './app/services/load_pairs'

describe LoadPairs do
  let(:assignments_source) { [
    [['jon', 'andrew'], ['bob', 'phil']],
    [['jon', 'phil'], ['bob', 'andrew']],
    [['jon', 'bob'], ['andrew', 'phil']]
  ] }

  let(:assignments_json) { assignments_source.to_json }
  let(:pairs_file) { double(:file, read: assignments_json)}
  let(:repo) { double :repo, set: nil, incr: nil }

  subject(:service) { LoadPairs.new(cohort: :test2017, file: pairs_file) }

  before do
    allow(PairAssignments).to receive(:repo).and_return(repo)
  end

  describe '::with' do
    it 'passes cohort and file to a new instance' do
      expect(LoadPairs).to receive(:new).with(cohort: :test2017, file: pairs_file).and_call_original
      LoadPairs.with(cohort: :test2017, file: pairs_file)
    end

    it 'runs an instance' do
      expect_any_instance_of(LoadPairs).to receive(:run)
      LoadPairs.with(cohort: :test2017, file: pairs_file)
    end
  end

  it 'creates the pair assignments for the given cohort' do
    expect(PairAssignments).to receive(:create).with(:test2017, assignments_source)
    service.run
  end
end
