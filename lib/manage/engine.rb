 require 'kaminari'
 require 'responders'
 require 'inherited_resources'
 require 'zurb-foundation'

 module Manage
  class Engine < ::Rails::Engine
    isolate_namespace Manage
  end
end
