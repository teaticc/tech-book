ActiveAdmin.register Book do
  index do
    selectable_column

    column :id do |book|
      link_to book.id, admin_book_path(book)
    end
    column :title do |book|
      link_to book.title, admin_book_path(book)
    end
    column :image do |book|
      if book.image.present?
        image_tag(book.image.url)
      end
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

  show do |book|
    attributes_table do
      row :title
      row :category
      row :price
      row :postage
      row :state
      row :detail
      row :seller, label: "出品者"
      row :buyer, label: "購入者"
      row :image do
        if book.image.present?
          image_tag(book.image.url)
        end
      end
    end
  end

  form do |f|
    inputs 'Book' do
      input :title
      input :category
      input :price
      input :postage
      input :state
      input :detail
      input :seller_id, as: :select, collection: User.all.collect { |user| user.nickname }, label: "出品者"
      input :image, as: :file, label: "画像"
    end
    actions
  end

end
