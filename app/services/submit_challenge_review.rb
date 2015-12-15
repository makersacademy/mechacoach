require "google/api_client"
require "google_drive"

class SubmitChallengeReview
  def self.with(content:, name:, github_user:)
    service = SubmitChallengeReview.new(content: content, name: name, github_user: github_user)
    service.run
  end

  def initialize(content:, name:, github_user:)
    @name = name
    @content = content
    @github_user = github_user
  end

  def run
    github_client.add_comment "makersacademy/#{name}", pull_request.number, create_review_comment
  end

  private

  attr_reader :content, :name, :github_user

  def create_review_comment
    review_summary = ReviewSummary.new(content: content, name: name, github_user: github_user, headings: headings)
    renderer = ERB.new(File.read('./app/views/challenge_review.erb'), nil, '-')
    renderer.result review_summary.get_binding
  end

  def headings
    @headings ||= worksheet.rows.first.reduce({}) do |hash, heading|
      key = heading.downcase.gsub(/\W/, '')
      hash[key] = heading unless IGNORE_HEADERS.include?(key.to_sym)
      hash
    end
  end

  def worksheet
    @worksheet ||= document.worksheet_by_gid(SubmitChallengeReview.worksheet_id(name))
  end

  def document
    @document ||= session.spreadsheet_by_key(SubmitChallengeReview.document_id(name))
  end

  def session
    @session ||= GoogleDrive.saved_session("./stored_token.json", nil, ENV['GAPI_CLIENT_ID'], ENV['GAPI_CLIENT_SECRET'])
  end

  def pull_request
    pull_requests = github_client.pull_requests "makersacademy/#{name}", state: 'open', per_page: 100
    pull_requests.find {|pr| pr.user.login.downcase == github_user.downcase }
  end

  def github_client
    @github ||= Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
  end

  class << self
    def document_id(name)
      config[name]['document_id']
    end

    def worksheet_id(name)
      config[name]['worksheet_id']
    end

    private

    def config
      @config ||= YAML.load(File.open('./config/submit_challenge_review.config'))
    end

  end

  IGNORE_HEADERS = [
    :whatistherevieweesgithubusername,
    :yourname,
    :whosechallengeareyoureviewing,
    :didyoufindthisformusefulincompletingthereview,
    :anyadditionalcommentsonthecodeyoureviewed,
    :timestamp,
    :features,
    :bonusfeatures,
    :adddetailsofyouralternateapproachtothereviewifyouskippedtherest
  ]

end
