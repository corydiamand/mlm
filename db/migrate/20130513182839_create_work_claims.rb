class CreateWorkClaims < ActiveRecord::Migration
  def change
    create_table :work_claims do |t|
      t.integer :user_id
      t.integer :work_id

      t.timestamps
    end
  end
end
