require 'sinatra/base'
require 'sinatra/flash'
require 'newrelic_rpm'

require './lib/parse_github'
require './lib/mechacoach'
require './lib/search'
require './lib/find_channel'
require './lib/parse_pair_file'
require './app/models/pair_assignments'
require './app/models/review_summary'
require './app/services/release_pairs'
require './app/services/load_pairs'
require './app/services/mechacoach_bot'

class MechacoachServer < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  get '/' do
    "wotcher."
  end

  post '/pairs/release' do
    ReleasePairs.with(team: params[:team], cohort: params[:cohort])
  end

  get '/pairs/load' do
    erb :'pairs/load'
  end

  post '/pairs' do
    team = params[:team]
    cohort = params[:cohort]
    pairs = params[:pairs][:tempfile]

    case FindChannel.with(team, cohort)
    when :ok
      LoadPairs.with(cohort: cohort, file: pairs)
      flash[:success] = "Your pairs (#{cohort}) were loaded successfully."
    when :wrong_team
      flash[:error] = "The Slack team '#{team}' doesn't appear to exist. Please try again."
    when :wrong_channel
      flash[:error] = "The Slack channel '#{cohort}' doesn't appear to exist. Please try again."
    when :server_error
      flash[:error] = "Something went wrong on the server. Please let Engineering know about this."
    end

    redirect '/pairs/load'
  end

  post '/slack/cohort' do
    body = JSON.parse(request.body.read)

    MechacoachBot.process(team_id: body['team_id'], event: body['event'])
  end

  post '/new-slack-overflow-issue' do
    payload = request.body.read
    issue_number = ParseGithub.with(payload)
    handler = Mechacoach.new
    handler.slack_overflow_issue(issue_number)
    200
  end

  post '/look-up' do
    searchResult = Search.new(search_term: params["text"]).run
    searchResult.summary
  end
end
