ENV["RAILS_ENV"] ||= 'test'

# Set up generator tests
require 'rails/all'
require 'rails/generators'
require 'rails/generators/test_case'
require 'load_schema'

class TestApp < Rails::Application
  config.root = File.dirname(__FILE__)
end
Rails.application = TestApp

module Rails
  def self.root
    @root ||= File.expand_path("../../tmp/rails", __FILE__)
  end
end
Rails.application.config.root = Rails.root

class ApplicationController < ActionController::Base
end

# Call configure to load the settings from
# Rails.application.config.generators to Rails::Generators
Rails::Generators.configure!


