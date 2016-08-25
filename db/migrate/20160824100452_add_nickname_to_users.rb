class AddNicknameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string
    remove_column :users, :fullname, :string
  end
end
