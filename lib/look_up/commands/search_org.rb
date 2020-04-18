module LookUp
  module Commands
    class SearchOrg
      def initialize(options)
        @search_term = options[:search_term]
        @search_org = options[:org]
      end

      def run
        Search.new(search_term: @search_term, search_org: @search_org, summary: summary).run
      end

      def summary
        "You searched for #{@search_term} in the Organisation '#{@search_org}'"
      end
    end
  end
end
