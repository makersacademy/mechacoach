feature 'challenge review summary posting' do

  summary = <<-MESSAGE
You had your rps-challenge reviewed by **Yev Dyko**

### The good points are:

* The README has instructions
* Every possible outcome of the game logic is tested at the unit level
* The feature tests test a reasonable subset of game logic
* Win, lose and draw outcomes are all tested at the feature level
* long if/elsif conditionals avoided in business logic
* Business and presentation logic has been cleanly separated
* Routes consistently named, Routes use of POST and GET is consistent
* The file structure followed recognizable conventions
* files and classes are named consistently
* There is no commented code
* The code minimizes the amout of business logic in the view
* The controllers are thin with minimal business logic

### You should consider the following improvements:

* Including presentation strings in business logic layer
* Use of global variables
* Not storing the weapons in a constant
* Defining weapons in more than one place
* Not initializing capybara/ spec_helper correctly
* Random behaviour not stubbed out at feature level

### Additional comments:
Reasonable attempt. Good job!

see https://github.com/makersacademy/rps-challenge/blob/master/docs/review.md for more details
MESSAGE

  let(:comment) { str }
  scenario 'posts the review summary as a comment on the pull request' do
    VCR.use_cassette('challenge_review') do
      post '/challenges/rps-challenge/reviews/tansaku', RPS_FORM_DATA
      expect(WebMock).to have_requested(:post, 'https://api.github.com/repos/makersacademy/rps-challenge/issues/219/comments')
        .with { |req| JSON.parse(req.body)['body'] == summary }
    end
  end

  RPS_FORM_DATA = {
    content: "anyadditionalcommentsonthecodeyoureviewed: Reasonable attempt. Good job!, \
callingbusinesslogicfromtheview: The code minimizes the amout of business logic in the view, \
didyoufindthisformusefulincompletingthereview: Dead link for this point \"Not initializing capybara/ spec_helper correctly\", \
fatcontrollers: The controllers are thin with minimal business logic, \
inconsistentfilenaming: files and classes are named consistently, \
inconsistentfolderlayoutsinatrastructure: The file structure followed recognizable conventions, \
inconsistentroutingandroutenaming: Routes consistently named, Routes use of POST and GET is consistent, \
notencapsulatingthecomputerinaseparateclass: Business and presentation logic has been cleanly separated, \
notinitializingcapybaraspechelpercorrectly: Capybara is initialized correctly, \
notremovingcommentsbeforecommitting: There is no commented code, \
nottestingallgameoutcomesinfeaturetests: Win, lose and draw outcomes are all tested at the feature level, \
nottestingallofthegamelogicinunittests: Every possible outcome of the game logic is tested at the unit level, \
readmeshouldhavescreenshotsandinstructionsonhowtouseapplication: The README has instructions, \
testingtoomuchgamelogicinfeaturetests: The feature tests test a reasonable subset of game logic, \
timestamp: 11/2/2015 10:20:31, \
useofifelsifconditionalsforbusinesslogic: long if/elsif conditionals avoided in business logic, \
whatistherevieweesgithubusername: tansaku, \
whosechallengeareyoureviewing: Andy Dowell, \
yourname: Yev Dyko"
}

end
