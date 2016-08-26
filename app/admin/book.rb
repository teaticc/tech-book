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
    column :seller_id
    column :buyer_id
  end

end
