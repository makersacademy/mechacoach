describe 'loading pairs via GUI' do
  it 'prompts the user to use the slack channel name' do
    visit '/pairs/load'
    expect(page).to have_content 'Use the precise form of the cohort channel name from Slack, without the prepended #. e.g. october2015'
  end

  context 'with a non-existent cohort name' do
    it 'asks the user to check the cohort name' do
      VCR.use_cassette('check_missing_cohort_channel_name') do
        visit '/pairs/load'
        fill_in('cohort', with: 'october 2015')
        attach_file('pairs', File.absolute_path('spec/fixtures/good_pairs.txt'))
        click_button 'Submit'
        expect(page).to have_content "'#october 2015' is not a student slack channel. Check the cohort name and try again."
      end
    end
  end

  context 'with an existent cohort name and a well-formed pair file' do
    it 'commits the pairs correctly' do
      VCR.use_cassette('check_cohort_channel_name') do
        Redis.new.set('october2015_pairs', nil)
        visit '/pairs/load'
        fill_in('cohort', with: 'october2015')
        attach_file('pairs', File.absolute_path('spec/fixtures/good_pairs.txt'))
        click_button 'Submit'
        expect(page).to have_content 'Your pairs (october2015) were loaded successfully.'
        expect(PairAssignments.find('october2015')).to be
      end
    end
  end
end
