class ChangeCopyrightDateInWorkrks < ActiveRecord::Migration
  def up
    change_column :works, :copyright_date, :date
  end

  def down
    change_column :works, :copyright_date, :string
  end
end
