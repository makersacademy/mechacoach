describe SubmitChallengeReview do

  review = YAML.load(File.read('./spec/fixtures/submit_challenge_review_data.yml'))
  meta =  YAML.load(File.read('./spec/fixtures/submit_challenge_meta_data.yml'))
  content = review.merge(meta)


  subject(:service) { SubmitChallengeReview.new(content: content, name: 'test_challenge', github_user: 'test_user') }

  let(:session) { double(:session, spreadsheet_by_key: document) }
  let(:document) { double(:document, worksheet_by_gid: worksheet) }
  let(:worksheet) { double(:document, rows: [content.keys.map(&:to_s).map(&:upcase)]) }

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
        expect(options[:content]).to eq content
        expect(options[:name]).to eq 'test_challenge'
        expect(options[:github_user]).to eq 'test_user'
      end.and_call_original

      allow_any_instance_of(SubmitChallengeReview).to receive(:run)

      SubmitChallengeReview.with(content: content, name: 'test_challenge', github_user: 'test_user')
    end

    it 'runs an instance' do
      expect_any_instance_of(SubmitChallengeReview).to receive(:run)
      SubmitChallengeReview.with(content: content, name: 'test_challenge', github_user: 'test_user')
    end
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
end
