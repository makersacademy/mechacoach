require 'load_env'
require 'rspec'
require 'capybara/rspec'
require 'capybara/json'
require_relative '../app/server'

ENV['RACK_ENV'] = 'test'

# Add Sinatra integration using Capybara
Capybara.app = MechacoachServer
Capybara.current_driver = :rack_test_json

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
