class RemoveWebIdFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :web_id
  end

  def down
    add_column :users, :web_id, :integer
  end
end
