class ChangeMrShareInWorkClaims < ActiveRecord::Migration
  def up
    change_column :work_claims, :mr_share, :float
  end

  def down
    change_column :work_claims, :mr_share, :integer
  end
end
