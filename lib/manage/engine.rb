require 'kaminari'
require 'responders'
require 'inherited_resources'
require 'simple_form'
require 'jquery-rails'
require 'zurb-foundation'
require 'devise'
require 'slim'
require 'search_object'

module Manage
  class Engine < ::Rails::Engine
    isolate_namespace Manage

    config.generators do |g|
      g.test_framework :rspec, :fixture => false
      g.assets false
      g.helper false
    end
  end
end
