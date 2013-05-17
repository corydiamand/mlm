class RemoveAudioProductIdFromWorks < ActiveRecord::Migration
  def up
    remove_column :works, :audio_product_id
  end

  def down
  end
end
