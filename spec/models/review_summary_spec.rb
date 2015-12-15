describe ReviewSummary do 
  # headings in the real system is a lookup table with entries like so
  # 'appropriateuseofdependencyinjection' => 'Appropiate Use of Dependency Injection'

  let(:headings) { Hash[CONTENT.keys.map{ |k| [k,k.upcase] }] }

  subject(:summary) { described_class.new(content: CONTENT, name: 'test_challenge', github_user: 'test_user', headings: headings) }

  it 'provides the name of the challenge' do
    expect(summary.name).to eq 'test_challenge'
  end

  it 'provides the reviewer of the challenge' do
    expect(summary.reviewer).to eq 'Jongmin Kim'
  end

  it 'lists the good parts' do
    good_parts = REVIEW.values.reject { |content| content.empty? }
    # require 'byebug' ; byebug
    good_parts.each do |content|
      expect(summary.good_parts).to include content
    end
  end

  it 'does not include needs improvement in good parts' do
    needs_improvement = REVIEW.select { |key, content| content.empty? }.map { |key, content| key.upcase }
    needs_improvement.each do |content|
      expect(summary.good_parts).not_to include content
    end
  end

  it 'lists the parts needing improvement' do
    # the needs_improvement headings will come from the google doc.
    # the mock of this just returns the uppercase of the key to prove it is called.
    needs_improvement = REVIEW.select { |key, content| content.empty? }.map { |key, content| key.upcase }
    needs_improvement.each do |content|
      expect(summary.needs_improvement).to include content
    end
  end

  it 'does not include good parts in needing improvement' do
    good_parts = REVIEW.values.reject { |content| content.empty? }
    good_parts.each do |content|
      expect(summary.needs_improvement).not_to include content.upcase
    end
  end

  it 'knows if there are additional comments' do
    expect(summary).to have_additional_comments
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