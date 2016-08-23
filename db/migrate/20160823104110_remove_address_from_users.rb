class RemoveAddressFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :address, :string
    remove_column :users, :first_name, :string
    remove_column :users, :family_name, :string
    remove_column :users, :phone_number, :string
    remove_column :users, :post_number, :string
  end
end
