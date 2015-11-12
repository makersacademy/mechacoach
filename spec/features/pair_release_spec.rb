feature 'Pair release slack notification' do
  let(:params) { { cohort: 'Test 2016', release_time: Time.now } }

  scenario 'the scheduler can send a post request to /pairs/release' do
    response = post('/pairs/release', params)
    expect(response.status).to eq 200
  end
end
