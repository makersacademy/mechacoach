require 'byebug'

feature 'Pair release slack notification' do
  context 'for one cohort "test2016"' do
    let(:params) { { cohort: 'test2016', release_time: Time.now } }
    let(:pairs) { Pairs.new([['jon', 'andrew'], ['andrew','jon']]) }

    before do
      allow_any_instance_of(Pairs).to receive(:find).with(:test2016).and_return(pairs)
      allow_any_instance_of(SlackNotifier).to receive(:notify)
    end

    scenario 'request to "/pairs/release" releases a pair assignment to slack' do
      expect_any_instance_of(SlackNotifier).to receive(:notify).with('pairs: jon, andrew')
      response = post('/pairs/release', params)
      expect(response.status).to eq 200
    end

    scenario 'second request to "/pairs/release" releases subsequent pair assignment in the sequence' do
      response = post('/pairs/release', params)

      expect_any_instance_of(SlackNotifier).to receive(:notify).with('pairs: andrew, jon')
      response = post('/pairs/release', params)
    end

    scenario 'pair release cycles when pairs have run out' do
      response = post('/pairs/release', params)
      response = post('/pairs/release', params)

      expect_any_instance_of(SlackNotifier).to receive(:notify).with('pairs: jon, andrew')
      response = post('/pairs/release', params)
    end
  end

  context 'for another cohort "test2017"' do
    let(:params) { { cohort: 'test2017', release_time: Time.now } }
    let(:store) {  { test2017: [['bob', 'phil'], ['phil','bob']] } }
    scenario 'requests to "/pairs/release" releases a pair assignment to slack' do
      allow(Pairs).to receive(:next).with('test2017').and_return(['bob', 'phil'])
      expect_any_instance_of(SlackNotifier).to receive(:notify).with('pairs: bob, phil')
      response = post('/pairs/release', params)
      expect(response.status).to eq 200
    end
  end


end
