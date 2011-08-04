class CreateWulinAuthUserTable < ActiveRecord::Migration
  def change
    if !ActiveRecord::Base.connection.tables.include?("users")
      create_table :users do |t|
        t.string :login
        t.string :password_digest
        t.timestamps
      end
    elsif !User.column_names.include?("password_digest")
      add_column :users, :password_digest, :string
    end
  end
end
