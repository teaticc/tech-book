class ChangeDescritionOfUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :post_number, :integer
    add_column :users, :post_number, :string
  end

  def self.down
    remove_column :users, :post_number, :string
    add_column :users, :post_number, :integer
  end
end
