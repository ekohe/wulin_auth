require_relative "lib/wulin_auth/version"

Gem::Specification.new do |s|
  s.name = "wulin_auth"
  s.version = WulinAuth::VERSION
  s.authors = ["Ekohe"]
  s.email = ["dev@ekohe.com"]
  s.homepage = "https://gitlab.ekohe.com/ekohe/wulin/wulin_auth"
  s.summary = "Authentication module for wulin_master"
  s.description = "This gem provides email-based authentication features."
  s.license = "MIT"

  s.files = `git ls-files`.split("\n")
  s.require_paths = ["lib"]

  s.required_ruby_version = ">= 3.4"

  s.add_dependency "bcrypt"
  s.add_dependency "haml"
  s.add_dependency "rails", ">= 8.1"
  s.add_dependency "zxcvbn-ruby"

  s.add_development_dependency "pg"
  s.add_development_dependency "propshaft"
  s.add_development_dependency "rspec-rails"
end
