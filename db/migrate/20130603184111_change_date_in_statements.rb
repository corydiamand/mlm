class ChangeDateInStatements < ActiveRecord::Migration
  def up
    rename_column :statements, :date, :date_temp
    add_column :statements, :date, :date
    # Statement.reset_column_information
    # Statement.find.each { |s| s.update_attribute(:date, c.date_temp) }
    remove_column :statements, :date_temp
  end

  def down
  end
end
