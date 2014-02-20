class RemoveUserIdFromStatements < ActiveRecord::Migration
  def up
    remove_column :statements, :user_id
  end

  def down
    add_column :statements, :user_id, :integer
  end
end
