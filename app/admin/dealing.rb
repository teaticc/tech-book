ActiveAdmin.register Dealing do

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

    column :id do |dealing|
      link_to dealing.id, admin_dealing_path(dealing)
    end
    column :book_id
    column "購入者" do |dealing|
      link_to dealing.book.buyer.nickname, admin_user_path(dealing.book.buyer)
    end
    column "出品者" do |dealing|
      link_to dealing.book.seller.nickname, admin_user_path(dealing.book.seller)
    end
    column "購入日時" do |dealing|
      dealing.created_at.in_time_zone("Tokyo")
    end
  end

end
