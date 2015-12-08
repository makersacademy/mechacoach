describe SubmitChallengeReview do
  subject(:service) { SubmitChallengeReview.new(content: CONTENT, name: 'test_challenge', github_user: 'test_user') }

  let(:session) { double(:session, spreadsheet_by_key: document) }
  let(:document) { double(:document, worksheet_by_gid: worksheet) }
  let(:worksheet) { double(:document, rows: [CONTENT.keys]) }

  config = YAML.load(File.open('./spec/fixtures/submit_challenge_review.config'))

  before do
    allow(GoogleDrive).to receive(:saved_session).and_return(session)
    allow(SubmitChallengeReview).to receive(:config).and_return(config)
  end

  describe '::with' do
    it 'passes arguments to new instance' do
      expect(SubmitChallengeReview).to receive(:new) do |options|
        expect(options[:content]).to eq CONTENT
        expect(options[:name]).to eq 'test_challenge'
        expect(options[:github_user]).to eq 'test_user'
      end.and_call_original

      SubmitChallengeReview.with(content: CONTENT, name: 'test_challenge', github_user: 'test_user')
    end

    it 'runs an instance' do
      expect_any_instance_of(SubmitChallengeReview).to receive(:run)
      SubmitChallengeReview.with(content: CONTENT, name: 'test_challenge', github_user: 'test_user')
    end
  end

  it 'fetches the worksheet from google' do
    expect(session).to receive(:spreadsheet_by_key).with('google_doc_id')
    service.run
  end

  CONTENT = {
      appropriateuseofdependencyinjection: "The Twilio dependency can be injected appropriately",
    designforsingleresponsibilityprinciple: "The design has at least `Takeaway` and `Order` classes or equivalent",
    didyoufindthisformusefulincompletingthereview: "I find the review introduction page very useful and helpful. If juniors have access to this information after each challenge, they'd give a better code review when they're seniors.",
    ensurethatallgemsbeingusedareingemfile: "Required gems (i.e. twilio-ruby) are listed in Gemfile",
    explicittestsforeveryelementofthepublicinterface: "All public interface elements are tested",
    explorethelanguageforsolutionstocommonproblems: "The solution makes good use of the Ruby language, e.g., Hash.new(0) is used to simplify management of counts",
    lawofdemeter: "The Law of Demeter is respected in the code base",
    openclosedprinciple: "The open closed principle has been respected, e.g. food items are not hard coded into restaurant",
    personaldetailsandtokensongithub: "ENV vars have been used in place of sensitive data",
    separationofconcerns: "Business and presentation logic has been cleanly separated",
    stubbingthetwilioapi: "The Twilio API is stubbed appropriately",
    testsshouldtestrealbehavioursnotstubs: "All tests test real behaviour and not stubs",
    timestamp: "10/23/2015 16:07:09",
    useconsistentstylesandindentation: "The code follows the Ruby style and coding conventions",
    whatistherevieweesgithubusername: "sarahkristinepedersen",
    whosechallengeareyoureviewing: "Sara",
    yourname: "Jongmin Kim"
  }
end
