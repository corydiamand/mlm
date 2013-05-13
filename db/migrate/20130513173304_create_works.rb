class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.integer :user_id
      t.integer :audio_product_id
      t.string :work_title
      t.string :duration
      t.string :copyright_date
      t.timestamps
    end

    add_index :works, :user_id
    add_index :works, :audio_product_id
  end
end
