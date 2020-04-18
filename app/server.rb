require 'sinatra/base'
require 'sinatra/flash'
require 'newrelic_rpm'

require './lib/parse_github'
require './lib/mechacoach'
require './lib/search'
require './lib/find_channel'
require './lib/parse_pair_file'
require './lib/look_up/look_up'

require './app/models/pair_assignments'
require './app/models/review_summary'

require './app/services/release_pairs'
require './app/services/load_pairs'
require './app/services/mechacoach_bot'

require './app/controllers/app_controller'
require './app/controllers/look_up_controller'
require './app/controllers/pairs_controller'
require './app/controllers/mechacoach_bot_controller'
require './app/controllers/slackoverflow_controller'
