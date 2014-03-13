class AddWebIdToWorkClaim < ActiveRecord::Migration
  def change
    add_column :work_claims, :web_id, :integer
  end
end
