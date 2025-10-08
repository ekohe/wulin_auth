require 'rails'

module WulinAuth
  class Engine < ::Rails::Engine
    # Propshaft configuration
    initializer "wulin_auth.assets", after: :append_assets_path, group: :all do |app|      
      if defined?(Propshaft)
        Rails.application.config.assets.paths << root.join("app", "assets", "stylesheets")
        Rails.application.config.assets.paths << root.join("app", "assets", "javascripts")
      end

      app.config.assets.precompile += %w[wulin_auth.js wulin_auth.css]
    end
    
    initializer :append_migrations do |app|
      config.paths['db/migrate'].expanded.each do |migration_path|
        app.config.paths['db/migrate'] << migration_path
      end
    end
  end
end
