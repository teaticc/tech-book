ActiveAdmin.register Book do
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
