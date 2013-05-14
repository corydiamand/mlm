class RemoveFmpColumns < ActiveRecord::Migration
  def up
    remove_column :users, :fmp_user_id
    remove_column :works, :fmp_work_id
  end

  def down
  end
end
