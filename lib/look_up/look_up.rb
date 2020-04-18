require_relative 'commands/help'
require_relative 'commands/search_org'
require_relative 'commands/search_repo'
require_relative 'look_up_response'

module LookUp
  class LookUp
    COMMANDS = {
      'help' => Commands::Help,
      'org' => Commands::SearchOrg,
      'repo' => Commands::SearchRepo
    }

    def initialize(data)
      @args = data["text"].split
    end

    def run
      command_class = COMMANDS.fetch(command)
      result = command_class.new(options).run
      LookUpResponse.new(result, @args)
    end

    private

    def search_term
      @args[0]
    end

    def repo
      @args[1]
    end

    def org
      @args[2]
    end

    def command
      return 'help' if @args[0] == 'help'
      repo.nil? ? 'org' : 'repo'
    end

    def options
      {
        search_term: search_term,
        repo: repo,
        org: 'makersacademy'
      }
    end
  end
end
