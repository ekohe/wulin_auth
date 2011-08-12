# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "wulin_auth/version"

Gem::Specification.new do |s|
  s.name        = "wulin_auth"
  s.version     = WulinAuth::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ekohe"]
  s.email       = ["team@ekohe.com"]
  s.homepage    = "http://rubygems.org/gems/wulin_auth"
  s.summary     = "Authentication module for wulin_master"
  s.description = "This gem provides an simple authentication function for wulin_master gem."

  s.rubyforge_project = "wulin_auth"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
