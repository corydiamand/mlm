class AddDateToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :date, :string
  end
end
