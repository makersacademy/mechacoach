require_relative 'search_result'

class Search
  def initialize(opts = {})
    @search_term = opts[:search_term]
    @search_repo = opts[:search_repo]
    @search_org = opts[:search_org]
    @summary = opts[:summary]
    @octokitClient = Octokit::Client.new(access_token: ENV["GITHUB_ACCESS_TOKEN"])
  end

  def run
    SearchResult.new(octokitClient.search_code(query), summary)
  end

  private

  attr_reader :octokitClient, :search_term, :search_repo, :search_org, :summary

  def query
    search_term + qualifiers
  end

  def qualifiers
    if search_repo.nil?
      "+org:#{search_org}"
    else
      "+repo:makersacademy/#{search_repo}"
    end
  end
end
