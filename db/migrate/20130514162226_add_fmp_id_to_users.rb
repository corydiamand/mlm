class AddFmpIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fmp_id, :integer
    add_index :users, :fmp_id
  end
end
