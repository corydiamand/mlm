class CreateAudioProducts < ActiveRecord::Migration
  def change
    create_table :audio_products do |t|
      t.integer :work_id
      t.string :artist
      t.string :album
      t.string :label
      t.string :catalog_number
      t.timestamps
    end

    add_index :audio_products, :work_id
  end
end
