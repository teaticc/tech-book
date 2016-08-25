class AddRegisteredToDealings < ActiveRecord::Migration
  def change
    add_column :dealings, :registered, :boolean
  end
end
