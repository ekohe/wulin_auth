# frozen_string_literal: true

class AddIndexForEmailInUsers < ActiveRecord::Migration[5.1]
  unless index_exists?(:users, :email, unique: true)
    def change
      add_index(:users, :email, unique: true)
    end
  end
end
