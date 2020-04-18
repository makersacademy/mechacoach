require_relative '../invalid_repo_error'

module LookUp
  module Commands
    class SearchRepo
      REPOS = %w(course skills-workshops)

      def initialize(options)
        @search_term = options[:search_term]
        @search_repo = options[:repo]
      end

      def run
        return InvalidRepoError.new(@search_repo, REPOS) unless REPOS.include?(@search_repo)

        Search.new(search_term: @search_term, search_repo: @search_repo, summary: summary).run
      end

      def summary
        "You searched for #{@search_term} in the Repository '#{@search_repo}'"
      end
    end
  end
end
