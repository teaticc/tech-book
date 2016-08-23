class RemoveSellerIdFromDealings < ActiveRecord::Migration
  def change
    remove_column :dealings, :seller_id, :integer
    remove_column :dealings, :buyer_id, :integer
    remove_column :books, :user_id, :integer
    add_column :books, :buyer_id, :integer
    add_column :books, :seller_id, :integer
    add_column :addresses, :addressable_type, :string
    add_column :addresses, :addressable_id, :integer
  end
end
