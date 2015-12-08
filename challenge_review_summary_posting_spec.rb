describe 'challenge review summary posting' do
  it 'calls the submit challenge review service with the relevant params' do
    expect(SubmitChallengeReview).to receive(:with) do |options|
      puts options
      expect(options[:content]).to eq FORM_DATA[:content]
      expect(options[:name]).to eq "challenge_name"
      expect(options[:github_user]).to eq "github_user"
    end
    post '/challenges/challenge_name/reviews/github_user', FORM_DATA
  end

  FORM_DATA = {
    document_id: "google_doc_id",
    worksheet_id: "google_sheet_id",
    content: {
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
  }
end
