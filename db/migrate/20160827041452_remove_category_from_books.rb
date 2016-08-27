class RemoveCategoryFromBooks < ActiveRecord::Migration
  def change
    remove_column :books, :category, :string
  end
end
