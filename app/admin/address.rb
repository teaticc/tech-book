ActiveAdmin.register Address do
  index do
    selectable_column

    column :id do |address|
      link_to address.id, admin_address_path(address)
    end
    column :family_name
    column :first_name
    column :order_email
    column :street_address
    column :post_number
    column :phone_number
    column "住所タイプ" do |address|
      if address.addressable_type == "User"
         link_to "ユーザー: #{address.addressable.nickname}", admin_user_path(address.addressable)
      else
         link_to "取引: #{address.addressable.book.title}", admin_dealing_path(address.addressable)
      end
    end
  end
end
