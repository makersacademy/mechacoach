require "google/api_client"
require "google_drive"

class SubmitChallengeReview
  def self.with(content:, name:, github_user:)
    # 1. identify the pull request to post to
    # 2. pull down the correct headers
    service = SubmitChallengeReview.new(content: content, name: name, github_user: github_user)
    service.run
  end

  attr_reader :content, :name, :github_user

  def initialize(content:, name:, github_user:)
    @content = content
    @name = name
    @github_user = github_user
  end

  def run
    worksheet.rows.first
  end

  private

  def worksheet
    document.worksheet_by_gid(SubmitChallengeReview.worksheet_id(name))
  end

  def document
    session.spreadsheet_by_key(SubmitChallengeReview.document_id(name))
  end

  def session
    @session ||= GoogleDrive.saved_session("./stored_token.json", nil, ENV['GAPI_CLIENT_ID'], ENV['GAPI_CLIENT_SECRET'])
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
      @config ||= YAML.load(File.open('./submit_challenge_review.config'))
    end

  end

end
