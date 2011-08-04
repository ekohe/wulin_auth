module WulinAuth
  class MigrationGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    source_root File.expand_path('../templates', __FILE__)
    
    def create_migration_file
      migration_template 'migration.rb', 'db/migrate/create_wulin_auth_user_table.rb'
    end
    
    def self.next_migration_number(dirname)
      if ActiveRecord::Base.timestamped_migrations
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      else
        "%.3d" % (current_migration_number(dirname) + 1)
      end
    end
  end
end
