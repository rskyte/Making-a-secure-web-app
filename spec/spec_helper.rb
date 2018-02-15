ENV['DB_ENV'] ||= 'test'
require 'capybara/rspec'
require 'simplecov'
require 'simplecov-console'
require_relative '../lib/db/db-connect'
require_relative '../server.rb'
require_relative 'features/web_helpers.rb'

Thread.new{ Server.new(3001, App).run }

Capybara.default_driver = :selenium
Capybara.app_host = 'http://localhost:3001'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
])
SimpleCov.start do
  add_filter "spec/hacks/hacks_spec.rb"
end

RSpec.configure do |config|
  config.filter_run_excluding :ignore => true

  config.around(:each) do |example|
	example.run
	DBConnect.access_database('truncate table users cascade;')
	DBConnect.access_database('truncate table posts cascade;')
  end
end
