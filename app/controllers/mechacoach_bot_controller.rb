class MechacoachServer < Sinatra::Base
  post '/slack/cohort' do
    body = JSON.parse(request.body.read)

    MechacoachBot.process(team_id: body['team_id'], event: body['event'])
  end
end
