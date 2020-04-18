class MechacoachServer < Sinatra::Base
  post '/look-up' do
    look_up_response = LookUp::LookUp.new(params).run
    look_up_response.body
  end
end
