ENV['RAILS_ENV'] ||= 'test'

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
load_schema = lambda {
  load "#{Rails.root.to_s}/db/schema.rb" # use db agnostic schema by default
}
silence_stream(STDOUT, &load_schema)


require 'rspec/rails'
require 'rspec/autorun'

Rails.backtrace_cleaner.remove_silencers!

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_tests = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.include Devise::TestHelpers, :type => :controller
  config.include Manage::Engine.routes.url_helpers
end
