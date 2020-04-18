class MechacoachServer < Sinatra::Base
  post '/new-slack-overflow-issue' do
    payload = request.body.read
    issue_number = ParseGithub.with(payload)
    handler = Mechacoach.new
    handler.slack_overflow_issue(issue_number)
    200
  end
end
