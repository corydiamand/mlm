class AddWebIdToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :web_id, :integer
  end
end
