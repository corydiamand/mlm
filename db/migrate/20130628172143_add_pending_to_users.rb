class AddPendingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pending, :boolean
  end
end
