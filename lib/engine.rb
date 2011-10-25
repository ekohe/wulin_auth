require 'wulin_auth'
require 'rails'
require 'action_controller'
require 'application_helper'

module WulinAuth
  class Engine < ::Rails::Engine
    initializer "add assets to precompile" do |app|
       app.config.assets.precompile += %w( wulin_auth.js wulin_auth.css )
    end
  end
end