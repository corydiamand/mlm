class FixWorkTitleName < ActiveRecord::Migration
  def up
    rename_column :works, :work_title, :title
  end

  def down
  end
end
