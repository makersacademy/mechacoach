require 'sinatra/base'
require './lib/parse_github'
require './lib/mechacoach'

class MechacoachServer < Sinatra::Base
  # before do
  #   request.body.rewind
  #   @request_payload = JSON.parse request.body.read
  # end

  get '/' do
    "wotcher."
  end

  post '/new-slack-overflow-issue' do
    payload = request.body.read
    issue_number = ParseGithub.with(payload)
    handler = Mechacoach.new
    handler.slack_overflow_issue(issue_number)
    200
  end
end