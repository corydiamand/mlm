class AddPendingToWorks < ActiveRecord::Migration
  def change
    add_column :works, :pending, :boolean, default: false
  end
end
