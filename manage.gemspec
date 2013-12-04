$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "manage/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "manage"
  s.version     = Manage::VERSION
  s.authors     = ["Empower United", "Gudata"]
  s.email       = ['devteam@empowerunited.com']
  s.license     = "MIT"
  s.homepage    = "https://github.com/empowerunited/manage"
  s.summary     = "Empower Unitited Manage Backend"
  s.description = "Rails backend"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"
  s.add_dependency "inherited_resources"
  s.add_dependency "kaminari"
  s.add_dependency "slim"
  s.add_dependency "slim-rails"
  s.add_dependency "responders"
  s.add_dependency "sass-rails",   "~> 4.0.0"
  s.add_dependency "coffee-rails", "~> 4.0.0"
  s.add_dependency "uglifier", ">= 1.3.0"
  s.add_dependency "compass-rails" # foundation needs this otherwise throws an error
  s.add_dependency "zurb-foundation", "~> 4.0.0"
  s.add_dependency "devise", "~> 3.1.0"

  s.add_development_dependency "sqlite3"
end
