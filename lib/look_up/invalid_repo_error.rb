module LookUp
  class InvalidRepoError < StandardError
    def initialize(repo, repos)
      @repo = repo
      @repos = repos
      super(msg=nil)
    end

    def message
      "The repository '#{@repo}' isn't searchable. Valid repositories are: #{@repos.join(', ')}"
    end

    def summary
      ''
    end

    def body
      message
    end
  end
end
