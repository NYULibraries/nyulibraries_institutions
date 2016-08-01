$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "nyulibraries_institutions/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "nyulibraries_institutions"
  s.version     = NyulibrariesInstitutions::VERSION
  s.authors     = ["Eric Griffis"]
  s.email       = ["eric.griffis@nyu.edu"]
  s.homepage    = "http://www.github.com/NYULibraries/nyulibraries_institutions"
  s.summary     = "NYULibraries institution helpers"
  s.description = "NYULibraries institution helpers for views and controllers"
  s.license     = "MIT"

  s.files = Dir["{app,config,lib}/**/**/*", "README.md"]

  s.add_dependency "rails", "~> 4.1.0"
  s.add_dependency "institutions", "~> 0.1.3"
end
