require 'sinatra/base'
require 'sinatra/flash'
require 'newrelic_rpm'

require './lib/parse_github'
require './lib/mechacoach'
require './lib/find_channel'
require './lib/parse_pair_file'
require './app/models/pair_assignments'
require './app/models/review_summary'
require './app/services/release_pairs'
require './app/services/load_pairs'
require './app/services/submit_challenge_review'

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
    end

    redirect '/pairs/load'
  end

  post '/new-slack-overflow-issue' do
    payload = request.body.read
    issue_number = ParseGithub.with(payload)
    handler = Mechacoach.new
    handler.slack_overflow_issue(issue_number)
    200
  end

  #  /challenges/bowling_challenge/reviews/tansaku
  post '/challenges/:name/reviews/:github_user' do
    p "Received Challenge Review for #{params[:github_user]}"
    content = MechacoachServer.sanitize_zap_content(params[:content])
    p "Zap content sanitised"
    SubmitChallengeReview.with(content: content, name: params[:name], github_user: params[:github_user])
    p "Challenge Review submitted"
    200
  end

  def self.sanitize_zap_content(content)
    Hash[content.split(/,\s(?=\w+\:)/).map{|s| s.split(': ',2)}]
  end
end
