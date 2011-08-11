require File.join(File.dirname(__FILE__), 'test_helper')

require 'generators/wulin_auth/migration_generator'
 
class MigrationGeneratorTest < Rails::Generators::TestCase
  tests WulinAuth::MigrationGenerator
  destination File.expand_path("../tmp", File.dirname(__FILE__))
  setup :prepare_destination

  test "all files are properly created" do
    run_generator
    assert_migration "db/migrate/create_wulin_auth_user_table.rb"
  end

  test "all files are properly deleted" do
    run_generator
    run_generator [], :behavior => :revoke
    assert_no_migration "db/migrate/create_wulin_auth_user_table.rb"
  end
 
end
