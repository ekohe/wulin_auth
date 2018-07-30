class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :token
      t.datetime :token_expires_at
      t.timestamps
    end unless table_exists?(:users)
  end
end
