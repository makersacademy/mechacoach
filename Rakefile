# Define tasks for Mechacoach in here

require 'dotenv'
require './lib/mechacoach'

task :before do
  Dotenv.load
end

# Example task
task :make_fearsome_comment => :before do
  coach = Mechacoach.new
  coach.be_fearsome
end