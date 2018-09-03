describe ReleasePairs do
  subject(:service) { ReleasePairs.new(team: 'makersstudents', cohort: :test2017) }

  let(:notifier) { double(:notifier, notify: nil) }

  let(:assignments_source) { [
    [['jon', 'andrew'], ['bob', 'phil']],
    [['jon', 'phil'], ['bob', 'andrew']],
    [['jon', 'bob'], ['andrew', 'phil']]
  ] }

  let(:assignments_json) { assignments_source.to_json }
  let(:repo) { double :repo, get: assignments_json, incr: nil }

  before do
    allow(PairAssignments).to receive(:repo).and_return(repo)
    allow(SlackNotifier).to receive(:new).and_return(notifier)
  end

  describe '::with' do
    it 'passes cohort to a new instance' do
      expect(ReleasePairs).to receive(:new).with(team: 'makersstudents', cohort: :test2017).and_call_original
      ReleasePairs.with(team: 'makersstudents', cohort: :test2017)
    end
    it 'runs an instance' do
      expect_any_instance_of(ReleasePairs).to receive(:run)
      ReleasePairs.with(team: 'makersstudents', cohort: :test2017)
    end
  end

  it 'finds the pair assignments for the given cohort' do
    expect(PairAssignments).to receive(:find).with(:test2017).and_call_original
    service.run
  end

  it 'notifies the student slack channel of the next pair' do
    allow_any_instance_of(PairAssignments).to receive(:next).and_return([['bob', 'sarah']])
    expect(SlackNotifier).to receive(:new) do |args|
      expect(args[:team]).to eq 'makersstudents'
      expect(args[:channel]).to eq '#test2017'
      notifier
    end
    expect(notifier).to receive(:notify) do |message|
      expect(message).to include 'bob, sarah'
    end
    service.run
  end

  it 'defaults to posting to the makersstudents slack' do
    allow_any_instance_of(PairAssignments).to receive(:next).and_return([['bob', 'sarah']])
    expect(SlackNotifier).to receive(:new) do |args|
      expect(args[:team]).to eq 'makersstudents'
      expect(args[:channel]).to eq '#test2017'
      notifier
    end
    expect(notifier).to receive(:notify) do |message|
      expect(message).to include 'bob, sarah'
    end

    ReleasePairs.with(cohort: :test2017)
  end
end
