$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "manage/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "manage"
  s.version     = Manage::VERSION
  s.authors     = ["Empower United", "Gudata"]
  s.email       = ["i.bardarov@gmail.com"]
  s.homepage    = "https://github.com/empowerunited/manage"
  s.summary     = "Empower Unitited Manage Backend"
  s.description = "Rails backend based on http://iain.nl/backends-in-rails-3-1"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"
  s.add_dependency "inherited_resources"
  s.add_dependency "kaminari"
  s.add_dependency "has_scope"
  s.add_dependency "slim"
  s.add_dependency "slim-rails"
  s.add_dependency "responders"

  s.add_development_dependency "sqlite3"
end
