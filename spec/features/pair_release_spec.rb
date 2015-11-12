require 'byebug'

feature 'Pair release slack notification' do
  context 'for one cohort "test2016"' do
    let(:params) { { cohort: 'test2016', release_time: Time.now } }
    let(:store) {  { test2016: [['jon', 'andrew'], ['andrew','jon']] } }

    scenario 'requests to "/pairs/release" releases a pair assignment to slack' do
      # allow_any_instance_of(Pairs).to receive(:fetch).with(:test2016).and_return([['jon', 'andrew'], ['andrew','jon']])
      allow(Pairs).to receive(:next).with('test2016').and_return(['jon', 'andrew'])
      expect_any_instance_of(SlackNotifier).to receive(:notify).with('pairs: jon, andrew')
      response = post('/pairs/release', params)
      expect(response.status).to eq 200
    end

    scenario 'requests to "/pairs/release" release subsequent pair assignment in the sequence' do
      allow(Pairs).to receive(:next).with('test2016').and_return(['jon', 'andrew'], ['andrew', 'jon'])
      response = post('/pairs/release', params) 
      expect_any_instance_of(SlackNotifier).to receive(:notify).with('pairs: andrew, jon')
      response = post('/pairs/release', params) 
      expect(response.status).to eq 200
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
