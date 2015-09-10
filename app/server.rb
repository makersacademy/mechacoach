require 'sinatra/base'
require './lib/parse_github'
require './lib/mechacoach'

class MechacoachServer < Sinatra::Base
  get '/' do
    "wotcher."
  end

  post '/new-slack-overflow-issue' do
    p params
    issue_number = ParseGithub.with(params)
    handler = Mechacoach.new
    handler.slack_overflow_issue(issue_number)
    200
  end
end