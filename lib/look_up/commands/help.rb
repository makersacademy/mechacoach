module LookUp
  module Commands
    class Help
      def initialize(options)
      end

      def run
        self
      end

      def body
        """
          try: `/look-up [search-term]` to search all of Makers' repositories\n
          or, hone your search with `/look-up [search-term] [specific Makers repo]`
        """
      end

      def summary
        "You used the 'help' command"
      end
    end
  end
end
