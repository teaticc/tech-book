ActiveAdmin.register Address do
  controller do
    def scoped_collection
      Address.includes(:addressable, {addressable: :book})
    end
  end

  index do
    selectable_column

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
    actions
  end

  filter :family_name
  filter :first_name
  filter :street_address
  filter :post_number
  filter :phone_number
  filter :addressable_type, label: "住所タイプ"
end
