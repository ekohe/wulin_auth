# frozen_string_literal: true

require 'rails'

module WulinAuth
  class Engine < ::Rails::Engine
    initializer "add assets to precompile" do |app|
      app.config.assets.precompile += %w[wulin_auth.js wulin_auth.css]
    end

    initializer :append_migrations do |app|
      config.paths['db/migrate'].expanded.each do |migration_path|
        app.config.paths['db/migrate'] << migration_path
      end
    end
  end
end
