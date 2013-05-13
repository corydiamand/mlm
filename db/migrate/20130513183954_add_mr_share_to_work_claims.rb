class AddMrShareToWorkClaims < ActiveRecord::Migration
  def change
    add_column :work_claims, :mr_share, :integer
  end
end
