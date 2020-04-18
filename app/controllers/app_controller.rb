class MechacoachServer < Sinatra::Base
  set :views, Proc.new { File.join(root, "..", "views") }
  enable :sessions
  register Sinatra::Flash

  get '/' do
    "wotcher."
  end
end
