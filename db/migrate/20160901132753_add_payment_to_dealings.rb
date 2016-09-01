class AddPaymentToDealings < ActiveRecord::Migration
  def change
    add_column :dealings, :payment, :integer, null: false
  end
end
