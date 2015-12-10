describe SubmitChallengeReview do
  subject(:service) { SubmitChallengeReview.new(content: CONTENT, name: 'test_challenge', github_user: 'test_user') }

  let(:session) { double(:session, spreadsheet_by_key: document) }
  let(:document) { double(:document, worksheet_by_gid: worksheet) }
  let(:worksheet) { double(:document, rows: [CONTENT.keys.map(&:to_s).map(&:upcase)]) }

  let(:github_client) { double(:github_client, pull_requests: [pull_request], add_comment: nil) }
  let(:pull_request) { double(:pull_request, number: 1234) }

  config = YAML.load(File.open('./spec/fixtures/submit_challenge_review.config'))

  before do
    allow(GoogleDrive).to receive(:saved_session).and_return(session)
    allow(SubmitChallengeReview).to receive(:config).and_return(config)
    allow(service).to receive(:github_client).and_return(github_client)
    allow(pull_request).to receive_message_chain('user.login.downcase').and_return('test_user')
  end

  describe '::with' do
    it 'passes arguments to new instance' do
      expect(SubmitChallengeReview).to receive(:new) do |options|
        expect(options[:content]).to eq CONTENT
        expect(options[:name]).to eq 'test_challenge'
        expect(options[:github_user]).to eq 'test_user'
      end.and_call_original

      allow_any_instance_of(SubmitChallengeReview).to receive(:run)

      SubmitChallengeReview.with(content: CONTENT, name: 'test_challenge', github_user: 'test_user')
    end

    it 'runs an instance' do
      expect_any_instance_of(SubmitChallengeReview).to receive(:run)
      SubmitChallengeReview.with(content: CONTENT, name: 'test_challenge', github_user: 'test_user')
    end
  end

  it 'provides the name of the challenge' do
    expect(service.name).to eq 'test_challenge'
  end

  it 'provides the reviewer of the challenge' do
    expect(service.reviewer).to eq 'Jongmin Kim'
  end

  it 'lists the good parts' do
    good_parts = REVIEW.values.reject { |content| content.empty? }
    require 'byebug'; byebug
    good_parts.each do |content|
      expect(service.good_parts).to include content
    end
  end

  it 'does not include needs improvement in good parts' do
    needs_improvement = REVIEW.select { |key, content| content.empty? }.map { |key, content| key.upcase }
    needs_improvement.each do |content|
      expect(service.good_parts).not_to include content
    end
  end

  it 'lists the parts needing improvement' do
    # the needs_improvement headings will come from the google doc.
    # the mock of this just returns the uppercase of the key to prove it is called.
    needs_improvement = REVIEW.select { |key, content| content.empty? }.map { |key, content| key.upcase }
    needs_improvement.each do |content|
      expect(service.needs_improvement).to include content
    end
  end

  it 'does not include good parts in needing improvement' do
    good_parts = REVIEW.values.reject { |content| content.empty? }
    good_parts.each do |content|
      expect(service.needs_improvement).not_to include content.upcase
    end
  end

  it 'knows if there are additional comments' do
    expect(service).to have_additional_comments
  end


  it 'fetches the worksheet from google' do
    expect(session).to receive(:spreadsheet_by_key).with('google_doc_id')
    service.run
  end

  it 'posts a comment to the relevant pull request on GitHub' do
    expect(github_client).to receive(:add_comment) do |repo, pr_number|
      expect(repo).to eq "makersacademy/test_challenge"
      expect(pr_number).to eq 1234
    end
    service.run
  end


  REVIEW = {
    'appropriateuseofdependencyinjection' => "The Twilio dependency can be injected appropriately",
    'designforsingleresponsibilityprinciple' => "The design has at least `Takeaway` and `Order` classes or equivalent",
    'ensurethatallgemsbeingusedareingemfile' => '',
    'explicittestsforeveryelementofthepublicinterface' => "",
    'explorethelanguageforsolutionstocommonproblems' => "The solution makes good use of the Ruby language, e.g., Hash.new(0) is used to simplify management of counts",
    'lawofdemeter' => "The Law of Demeter is respected in the code base",
    'openclosedprinciple' => "The open closed principle has been respected, e.g. food items are not hard coded into restaurant",
    'personaldetailsandtokensongithub' => "ENV vars have been used in place of sensitive data",
    'separationofconcerns' => "Business and presentation logic has been cleanly separated",
    'stubbingthetwilioapi' => "The Twilio API is stubbed appropriately",
    'testsshouldtestrealbehavioursnotstubs' => "All tests test real behaviour and not stubs",
    'useconsistentstylesandindentation' => "The code follows the Ruby style and coding conventions",
  }

  META =  {
    'timestamp' => "10/23/2015 16:07:09",
    'whatistherevieweesgithubusername' => "sarahkristinepedersen",
    'whosechallengeareyoureviewing' => "Sara",
    'yourname' => "Jongmin Kim",
    'didyoufindthisformusefulincompletingthereview' => "I find the review introduction page very useful and helpful. If juniors have access to this information after each challenge, they'd give a better code review when they're seniors.",
    'adddetailsofyouralternateapproachtothereviewifyouskippedtherest' => '',
    'anyadditionalcommentsonthecodeyoureviewed' => 'testing additional comments'
  }

  CONTENT = REVIEW.merge(META)
end
