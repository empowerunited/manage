 require 'kaminari'
 require 'responders'
 require 'inherited_resources'
 require 'zurb-foundation'
 require 'devise'

 module Manage
  class Engine < ::Rails::Engine
    isolate_namespace Manage
  end
end
