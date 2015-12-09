require "google/api_client"
require "google_drive"

class SubmitChallengeReview
  def self.with(content:, name:, github_user:)
    # 1. identify the pull request to post to
    # 2. pull down the correct headers
    service = SubmitChallengeReview.new(content: content, name: name, github_user: github_user)
    service.run
  end

  attr_reader :content, :name, :github_user, :reviewer

  def initialize(content:, name:, github_user:)
    @content = content
    @name = name
    @github_user = github_user
    @reviewer = @content['yourname']
  end

  def run
    puts good_parts
    puts needs_improvement
    puts create_review_comment
  end

  def good_parts
    good_headings = headings.keys.select { |key| content[key] && !content[key].empty? }
    good_headings.map { |key| content[key] }
  end

  def needs_improvement
    ni_headings = headings.keys.reject { |key| content[key] && !content[key].empty? }
    ni_headings.map { |key| headings[key] }
  end

  def has_additional_comments?
    content['anyadditionalcommentsonthecodeyoureviewed'] && !content['anyadditionalcommentsonthecodeyoureviewed'].empty?
  end

  def additional_comments
    content['anyadditionalcommentsonthecodeyoureviewed']
  end

  private

  def create_review_comment
    renderer = ERB.new(File.read('./app/views/challenge_review.erb'))
    renderer.result binding
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
