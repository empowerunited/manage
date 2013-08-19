 require 'kaminari'
 require 'responders'
 require 'inherited_resources'

 module Manage
  class Engine < ::Rails::Engine
    isolate_namespace Manage
  end
end
