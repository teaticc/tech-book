class RemoveAmazonUrlFromBooks < ActiveRecord::Migration
  def change
    remove_column :books, :amazon_url, :string
    add_column :books, :amazon_url, :text
  end
end
