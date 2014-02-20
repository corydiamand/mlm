class AddWebIdToUsersAgain < ActiveRecord::Migration
  def change
    add_column :users, :web_id, :integer
  end
end
