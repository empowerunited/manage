 require 'kaminari'
 require 'responders'
 require 'inherited_resources'
 require 'simple_form'
 require 'zurb-foundation'
 require 'devise'

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
