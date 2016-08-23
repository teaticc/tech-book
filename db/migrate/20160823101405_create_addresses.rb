class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :family_name
      t.string :order_email
      t.string :street_address
      t.string :post_number
      t.string :phone_number
      t.timestamps null: false
    end
  end
end
