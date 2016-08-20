class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :category
      t.integer :price
      t.integer :postage
      t.string :detail
      t.string :state
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
