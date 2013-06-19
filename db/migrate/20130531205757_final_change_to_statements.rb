class FinalChangeToStatements < ActiveRecord::Migration
  def up
    change_column :statements, :amount, :float
    change_column :statements, :date, :string
  end

  def down
  end
end
