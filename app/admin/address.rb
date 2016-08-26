ActiveAdmin.register Address do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

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
    # column "出品者" do |address|
    #   link_to address.book.seller.nickname, admin_user_path(address.book.seller)
    # end
    # column "購入日時" do |address|
    #   address.created_at.in_time_zone("Tokyo")
    # end
  end
end
