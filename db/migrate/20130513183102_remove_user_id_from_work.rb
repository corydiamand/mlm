class RemoveUserIdFromWork < ActiveRecord::Migration
  def up
    remove_column :works, :user_id
  end

  def down
    add_column :works, :user_id, :integer
  end
end
