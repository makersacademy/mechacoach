class MechacoachServer < Sinatra::Base
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
end
