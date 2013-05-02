class AddColumsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :admin, :boolean
    add_column :users, :encrypted_password, :string
    add_column :users, :salt, :string
    add_column :users, :remember_token, :string
    add_column :users, :area_code, :string
    add_column :users, :phone_number, :string
    add_column :users, :apartment_number, :string
    add_column :users, :address_number, :string
    add_column :users, :street_name, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zip_code, :string
    add_column :users, :password_reset_token, :string
    add_column :users, :password_reset_sent_at, :datetime
    add_index :users, :email
    add_index :users, :first_name
    add_index :users, :last_name
  end
end
