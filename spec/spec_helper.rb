ENV['RACK_ENV'] = 'test'

require_relative '../app/server'
require 'load_env'
require 'rspec'
require 'rack/test'
require 'capybara/rspec'
require 'capybara/json'

# Add Sinatra integration using Capybara
Capybara.app = MechacoachServer

require 'pry'
require 'vcr'
require 'webmock/rspec'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock # or :fakeweb
end

# Configure RSpec
RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Capybara::Json

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
