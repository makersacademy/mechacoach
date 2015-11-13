require 'sinatra/base'
require 'sinatra/flash'
require './lib/parse_github'
require './lib/mechacoach'
require './lib/find_channel'
require './lib/parse_pair_file'
require './lib/pair_loader'
require './app/models/pair_assignments'

require 'byebug'

class MechacoachServer < Sinatra::Base
  # before do
  #   request.body.rewind
  #   @request_payload = JSON.parse request.body.read
  # end

  enable :sessions
  register Sinatra::Flash

  get '/' do
    "wotcher."
  end

  post '/pairs/release' do
    assignments = PairAssignments.find(params[:cohort])
    pairs = assignments.next.map{|a| a.join(", ")}.join("\n")
    SlackNotifier.new.notify("pairs:\n\n#{pairs}")
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

    pairs = ParsePairFile.with(params[:pairs][:tempfile])

    if PairLoader.new(pairs).commit(cohort)
      flash[:success] = "Your pairs (#{cohort}) were loaded successfully."
    end
  end

  post '/new-slack-overflow-issue' do
    payload = request.body.read
    issue_number = ParseGithub.with(payload)
    handler = Mechacoach.new
    handler.slack_overflow_issue(issue_number)
    200
  end
end
