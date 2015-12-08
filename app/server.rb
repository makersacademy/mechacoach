require 'sinatra/base'
require 'sinatra/flash'
require './lib/parse_github'
require './lib/mechacoach'
require './lib/find_channel'
require './lib/parse_pair_file'
require './app/models/pair_assignments'
require './app/services/release_pairs'
require './app/services/load_pairs'

class MechacoachServer < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  get '/' do
    "wotcher."
  end

  post '/pairs/release' do
    ReleasePairs.with(cohort: params[:cohort])
  end

  get '/pairs/load' do
    erb :'pairs/load'
  end

  post '/pairs' do
    cohort = params[:cohort]

    unless FindChannel.with(cohort)
      flash[:error] = "'##{cohort}' is not a student slack channel. Check the cohort name and try again."
      redirect '/pairs/load'
    end

    LoadPairs.with(cohort: cohort, file: params[:pairs][:tempfile])

    flash[:success] = "Your pairs (#{cohort}) were loaded successfully."
  end

  post '/new-slack-overflow-issue' do
    payload = request.body.read
    issue_number = ParseGithub.with(payload)
    handler = Mechacoach.new
    handler.slack_overflow_issue(issue_number)
    200
  end

  post '/challenges/:name/review' do
    params.to_s
  end
end
