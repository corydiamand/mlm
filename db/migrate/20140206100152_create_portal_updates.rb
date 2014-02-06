class CreatePortalUpdates < ActiveRecord::Migration
  def change
    create_table :portal_updates do |t|
      t.timestamp :date
      t.references :user

      t.timestamps
    end
    add_index :portal_updates, :user_id
  end
end
