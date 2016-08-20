class CreateDealings < ActiveRecord::Migration
  def change
    create_table :dealings do |t|
      t.integer :seller_id
      t.integer :buyer_id
      t.integer :book_id
      t.timestamps null: false
    end
  end
end
