# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)
require "wulin_auth/version"
Gem::Specification.new do |s|
  s.name = "wulin_auth"
  s.version = WulinAuth::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Ekohe"]
  s.email = ["info@ekohe.com"]
  s.homepage = "http://rubygems.org/gems/wulin_auth"
  s.summary = "Authentication module for wulin_master"
  s.description = "This gem provides email-based authentication features."

  s.files = `git ls-files`.split("\n")
  s.executables = []
  s.require_paths = ["lib"]

  s.add_dependency "bcrypt"
  s.add_dependency "coffee-script"
  s.add_dependency "haml"
  s.add_dependency "jquery-rails"
  s.add_dependency "material_icons"
  s.add_dependency "materialize-sass"
  s.add_dependency "rails"
  s.add_dependency "sass-rails"
  # The 1.x API, pinned. PasswordComplexityValidator calls `Zxcvbn::Tester.new` with no arguments;
  # 2.0.1 made that `Tester.new(data:, max_password_length:)`, so a host app resolving the latest
  # gets `ArgumentError: missing keywords: :data, :max_password_length` the first time it saves a
  # user -- and the error names neither this gem nor the password, so it reads as a bad seed value.
  s.add_dependency "zxcvbn-ruby", "~> 1.0"
  s.add_development_dependency "pg"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "standardrb"
end
