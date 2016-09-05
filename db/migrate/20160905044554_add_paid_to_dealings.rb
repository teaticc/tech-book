class AddPaidToDealings < ActiveRecord::Migration
  def change
    add_column :dealings, :paid, :boolean
  end
end
