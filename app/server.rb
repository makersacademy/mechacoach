require 'sinatra'
require './lib/mechacoach'

get '/' do
  "wotcher."
end

post '/new-slack-overflow-issue' do
  "#{params}"
end