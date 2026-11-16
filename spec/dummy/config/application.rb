require_relative "boot"

require "rails/all"
require "propshaft"

Bundler.require(*Rails.groups)
require "wulin_auth"

module Dummy
  class Application < Rails::Application
    config.load_defaults 8.0
  end
end
