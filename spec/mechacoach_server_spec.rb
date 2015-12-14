describe MechacoachServer do
  it 'sanitizes text content from zapier into a hash' do
    content = MechacoachServer.sanitize_zap_content ZAP_CONTENT
    expect(content.keys).to include 'inconsistentroutingandroutenaming'
  end

  ZAP_CONTENT = <<-ZAP
anyadditionalcommentsonthecodeyoureviewed: Nice work. SRP used well, skinny controllers, succinct methods.
There were 2 failing tests:

Failures:

  1) Game Result Player wins
     Failure/Error: expect(page).to have_content 'Congratulations, you win!'
       expected to find text "Congratulations, you win!" in "You chose rock. The computer chose scissors Bad luck, you lose!"
     # ./spec/features/result_spec.rb:7:in `block (2 levels) in <top (required)>'

  2) Game Result A draw
     Failure/Error: expect(page).to have_content 'It\'s a draw!'
       expected to find text "It's a draw!" in "You chose rock. The computer chose rock Bad luck, you lose!"
     # ./spec/features/result_spec.rb:23:in `block (2 levels) in <top (required)>'

I did experience the above when testing the website, check the results method., callingbusinesslogicfromtheview: The code minimizes the amout of business logic in the view, definingweaponsinmorethanoneplace: The code defines weapons in a single place, fatcontrollers: The controllers are thin with minimal business logic, includingpresentationstringsinbusinesslogiclayer: Presentation strings not in business layer, inconsistentfilenaming: files and classes are named consistently, inconsistentroutingandroutenaming: Routes consistently named, Routes use of POST and GET is consistent, notencapsulatingthecomputerinaseparateclass: Business and presentation logic has been cleanly separated, notinitializingcapybaraspechelpercorrectly: Capybara is initialized correctly, notremovingcommentsbeforecommitting: There is no commented code, notstoringtheweaponsinaconstant: weapons are sensibly stored in a constant, nottestingallgameoutcomesinfeaturetests: Win, lose and draw outcomes are all tested at the feature level, randombehaviournotstubbedoutatfeaturelevel: Feature tests stub random behaviour, testingtoomuchgamelogicinfeaturetests: The feature tests test a reasonable subset of game logic, timestamp: 12/14/2015 10:06:31, useofifelsifconditionalsforbusinesslogic: long if/elsif conditionals avoided in business logic, whatistherevieweesgithubusername: trbradley, whosechallengeareyoureviewing: Tom Bradley, yourname: dan
ZAP
end
