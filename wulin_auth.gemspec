# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require "wulin_auth/version"
Gem::Specification.new do |s|
  s.name        = "wulin_auth"
  s.version     = WulinAuth::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ekohe"]
  s.email       = ["info@ekohe.com"]
  s.homepage    = "http://rubygems.org/gems/wulin_auth"
  s.summary     = "Authentication module for wulin_master"
  s.description = "This gem provides email-based authentication features."

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = []
  s.require_paths = ["lib"]

  s.add_dependency 'bcrypt'
  s.add_dependency 'coffee-script'
  s.add_dependency 'haml'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'material_icons'
  s.add_dependency 'materialize-sass'
  s.add_dependency 'rails'
  s.add_dependency 'sass-rails'
  s.add_dependency 'zxcvbn-ruby'
  s.add_development_dependency 'pg'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rubocop'
end
