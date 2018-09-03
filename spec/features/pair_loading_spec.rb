describe 'loading pairs via GUI' do
  it 'prompts the user to use the slack channel name' do
    visit '/pairs/load'
    expect(page).to have_content 'Use the precise form of the cohort channel name from Slack, without the prepended #. e.g. october2015'
  end

  it 'prompts the user to select a slack user group' do
    visit '/pairs/load'
    expect(page).to have_content 'Please select the slack group – Apprenticeships or Academy'
  end

  context 'with a non-existent cohort name' do
    it 'asks the user to check the cohort name' do
      VCR.use_cassette('check_missing_cohort_channel_name') do
        visit '/pairs/load'
        select('makersstudents', from: 'team')
        fill_in('cohort', with: 'october 2015')
        attach_file('pairs', File.absolute_path('spec/fixtures/good_pairs.txt'))
        click_button 'Submit'
        expect(page).to have_content "Check the team and cohort names and try again."
      end
    end
  end

  context 'with an existent team, cohort name and a well-formed pair file' do
    it 'commits the pairs correctly' do
      VCR.use_cassette('check_cohort_channel_name') do
        Redis.new.set('october2015_pairs', nil)
        visit '/pairs/load'
        select('makersstudents', from: 'team')
        fill_in('cohort', with: 'october2015')
        attach_file('pairs', File.absolute_path('spec/fixtures/good_pairs.txt'))
        click_button 'Submit'
        expect(page).to have_content 'Your pairs (october2015) were loaded successfully.'
        expect(PairAssignments.find('october2015')).to be
      end
    end
  end

  context 'with the apprenticeships team and an existent cohort' do
    it 'commits the pairs correctly' do
      VCR.use_cassette('check_apprenticeships_cohort_channel_name') do
        Redis.new.set('aug2018_pairs', nil)
        visit '/pairs/load'
        select('makersapprenticeships', from: 'team')
        fill_in('cohort', with: 'aug2018')
        attach_file('pairs', File.absolute_path('spec/fixtures/good_pairs.txt'))
        click_button 'Submit'
        expect(page).to have_content 'Your pairs (aug2018) were loaded successfully.'
        expect(PairAssignments.find('aug2018')).to be
      end
    end
  end
end
