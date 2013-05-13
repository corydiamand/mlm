class AddIndexToWorkClaims < ActiveRecord::Migration
  def change
    add_index :work_claims, :user_id
    add_index :work_claims, :work_id
  end
end
