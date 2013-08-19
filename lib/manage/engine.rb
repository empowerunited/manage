 require 'responders'
 require 'inherited_resources'
 require 'has_scope'

 module Manage
  class Engine < ::Rails::Engine
    isolate_namespace Manage
  end
end
