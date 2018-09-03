feature 'Pair release slack notification' do

  before { allow_any_instance_of(SlackNotifier).to receive(:notify) }

  context 'for one cohort "test2016"' do
    let(:assignments_source) do
      [
        [['jon', 'andrew'], ['bob', 'phil']],
        [['jon', 'phil'], ['bob', 'andrew']],
        [['jon', 'bob'], ['andrew', 'phil']]
      ]
    end

    let(:params) { { team: 'makersstudents', cohort: 'test2016', release_time: Time.now } }

    before do
      PairAssignments.repo.set("test2016_pairs", assignments_source.to_json)
      PairAssignments.repo.set("test2016_index", 0)
    end

    scenario 'request to "/pairs/release" releases a pair assignment to slack' do
      expect_any_instance_of(SlackNotifier).to receive(:notify).with("<!channel> assignments for your next pairing session:\n\njon, andrew\nbob, phil")
      response = post('/pairs/release', params)
      expect(response.status).to eq 200
    end

    scenario 'second request to "/pairs/release" releases subsequent pair assignment in the sequence' do
      post('/pairs/release', params)

      expect_any_instance_of(SlackNotifier).to receive(:notify).with("<!channel> assignments for your next pairing session:\n\njon, phil\nbob, andrew")
      post('/pairs/release', params)
    end

    scenario 'pair release cycles when pairs have run out' do
      assignments_source.count.times { post('/pairs/release', params) }

      expect_any_instance_of(SlackNotifier).to receive(:notify).with("<!channel> assignments for your next pairing session:\n\njon, andrew\nbob, phil")
      response = post('/pairs/release', params)
    end
  end

  context 'for another cohort "test2017"' do
    let(:assignments_source) do
      [ [['sarah', 'suleiman'], ['xeno', 'ermintrude']] ]
    end

    let(:params) { { team: 'makersstudents', cohort: 'test2017', release_time: Time.now } }

    before do
      PairAssignments.repo.set("test2017_pairs", assignments_source.to_json)
      PairAssignments.repo.set("test2017_index", 0)
    end

    scenario 'requests to "/pairs/release" releases a pair assignment to slack' do
      expect_any_instance_of(SlackNotifier).to receive(:notify).with("<!channel> assignments for your next pairing session:\n\nsarah, suleiman\nxeno, ermintrude")
      response = post('/pairs/release', params)
      expect(response.status).to eq 200
    end
  end

end
