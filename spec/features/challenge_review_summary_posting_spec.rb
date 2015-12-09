describe 'challenge review summary posting' do
  it 'calls the submit challenge review service with the relevant params' do
    expect(SubmitChallengeReview).to receive(:with) do |options|
      expect(options[:content]).to eq converted_form_data
      expect(options[:name]).to eq "challenge_name"
      expect(options[:github_user]).to eq "github_user"
    end
    post '/challenges/challenge_name/reviews/github_user', FORM_DATA
  end

  def converted_form_data
    FORM_DATA.reduce({}) do |hash, pair|
      key = pair[0]
      value = pair[1]
      hash[key.sub('Gsx$', '')] = value if key.start_with? 'Gsx$'
      hash
    end
  end

  FORM_DATA = {
    'Gsx$appropriateuseofdependencyinjection' => "The Twilio dependency can be injected appropriately",
    'Gsx$designforsingleresponsibilityprinciple' => "The design has at least `Takeaway` and `Order` classes or equivalent",
    'Gsx$didyoufindthisformusefulincompletingthereview' => "I find the review introduction page very useful and helpful. If juniors have access to this information after each challenge, they'd give a better code review when they're seniors.",
    'Gsx$ensurethatallgemsbeingusedareingemfile' => "Required gems (i.e. twilio-ruby) are listed in Gemfile",
    'Gsx$explicittestsforeveryelementofthepublicinterface' => "All public interface elements are tested",
    'Gsx$explorethelanguageforsolutionstocommonproblems' => "The solution makes good use of the Ruby language, e.g., Hash.new(0) is used to simplify management of counts",
    'Gsx$lawofdemeter' => "The Law of Demeter is respected in the code base",
    'Gsx$openclosedprinciple' => "The open closed principle has been respected, e.g. food items are not hard coded into restaurant",
    'Gsx$personaldetailsandtokensongithub' => "ENV vars have been used in place of sensitive data",
    'Gsx$separationofconcerns' => "Business and presentation logic has been cleanly separated",
    'Gsx$stubbingthetwilioapi' => "The Twilio API is stubbed appropriately",
    'Gsx$testsshouldtestrealbehavioursnotstubs' => "All tests test real behaviour and not stubs",
    'Gsx$timestamp' => "10/23/2015 16:07:09",
    'Gsx$useconsistentstylesandindentation' => "The code follows the Ruby style and coding conventions",
    'Gsx$whatistherevieweesgithubusername' => "sarahkristinepedersen",
    'Gsx$whosechallengeareyoureviewing' => "Sara",
    'Gsx$yourname' => "Jongmin Kim",
    'content' => 'blah blah blah'
  }
end
