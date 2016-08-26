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
      if book.seller.present?
        link_to book.seller.nickname, admin_user_path(book.seller)
      else
        "管理者"
      end
    end
    column "購入者" do |book|
      if book.buyer.present?
        link_to book.buyer.nickname, admin_user_path(book.buyer)
      else
        "出品中"
      end
    end
  end

  form do |f|
    inputs 'Book' do
      input :title
      input :category
      input :price, label: "価格(送料/税別):"
      input :postage
      input :detail
      input :state
      input :image, as: :file
      input :seller_id, as: :select, collection: User.all.collect { |user| user.nickname }
    end
    actions
  end

end
