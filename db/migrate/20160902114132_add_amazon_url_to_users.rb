class AddAmazonUrlToUsers < ActiveRecord::Migration
  def change
    add_column :books, :amazon_url, :string
  end
end
