class ChangeDateInStatements < ActiveRecord::Migration
  def up
    change_column :statements, :date, :date
  end

  def down
    change_column :statements, :date, :string
  end
end
