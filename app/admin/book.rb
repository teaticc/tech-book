ActiveAdmin.register Book do

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

    column :id do |book|
      link_to book.id, admin_book_path(book)
    end
    column :title do |book|
      link_to book.title, admin_book_path(book)
    end
    column :category
    column :price
    column :postage
    column :state
    column "出品者" do |book|
      link_to book.seller.nickname, admin_user_path(book.seller)
    end
    column "購入者" do |book|
      if book.buyer.present?
        link_to book.buyer.nickname, admin_user_path(book.buyer)
      else
        "出品中"
      end
    end
  end

end
