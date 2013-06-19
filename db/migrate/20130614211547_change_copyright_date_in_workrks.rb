class ChangeCopyrightDateInWorkrks < ActiveRecord::Migration
  def up
    change_column :works, :copyright_date, :copyright_date_temp
    add_column :works, :copyright_date, :date
    # Work.reset_column_information
    # Work.find.each { |w| w.update_attribute(:copyright_date, c.copyright_date_temp) }
    remove_column :works, :copyright_date_temp
  end

  def down
  end
end
