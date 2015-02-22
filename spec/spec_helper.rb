require 'rack/test'
require 'rspec'
require 'factory_girl'
require 'faker'
require "byebug"
require File.expand_path '../../app.rb', __FILE__
Dir[File.dirname(__FILE__)+"/factories/*.rb"].each {|file| require file }
require 'database_cleaner'

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

RSpec.configure do |config|

  config.include RSpecMixin
  # Database cleaning strategy
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction  
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end