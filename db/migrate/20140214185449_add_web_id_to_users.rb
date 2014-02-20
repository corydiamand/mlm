class AddWebIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :web_id, :integer
    add_index :users, :web_id, :unique => true
  end
end
