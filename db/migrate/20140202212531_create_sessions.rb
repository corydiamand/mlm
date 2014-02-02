class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.timestamp :login
      t.timestamp :logout
      t.references :user

      t.timestamps
    end
    add_index :sessions, :user_id
  end
end
