class AddIdToWorks < ActiveRecord::Migration
  def change
    add_column :works, :fmp_work_id, :integer
    rename_column :users, :fmp_id, :fmp_user_id
    add_index :works, :fmp_work_id
  end
end
