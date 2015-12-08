require "google/api_client"
require "google_drive"

class SubmitChallengeReview
  def self.with(content:, name:, github_user:)
    # 1. identify the pull request to post to
    # 2. pull down the correct headers
    service = SubmitChallengeReview.new(content: content, name: name, github_user: github_user)
    service.run
  end

  def initialize(content:, name:, github_user:)

  end

  def run
    session = GoogleDrive.saved_session("./stored_token.json", nil, ENV['GAPI_CLIENT_ID'], ENV['GAPI_CLIENT_SECRET'])
    ws = session.spreadsheet_by_key('1DxFAHuoub4MnIuRNDOfoCaUWNgrt9Z3LzGUfD6kMubs').worksheets[0]
    ws.rows[0].join(', ')
  end
end
