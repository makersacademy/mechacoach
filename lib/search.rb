require_relative 'search_result'

class Search
  SCOPES = %w(course skills-workshops)

  def initialize(search_term: )
    @search_term = search_term
    @octokitClient = Octokit::Client.new(access_token: ENV["GITHUB_ACCESS_TOKEN"])
  end

  def run
    SearchResult.new(octokitClient.search_code(query))
  end

  private

  attr_reader :octokitClient, :search_term

  def query
    search_term + repo
  end

  def repo
    "+repo:makersacademy/skills-workshops"
  end
end
