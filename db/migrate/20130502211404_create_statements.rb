class CreateStatements < ActiveRecord::Migration
  def change
    create_table :statements do |t|
      t.integer :user_id
      t.string :quarter
      t.string :year
      t.decimal :amount
      t.string :filename

      t.timestamps
    end
    add_index :statements, :user_id
  end
end
