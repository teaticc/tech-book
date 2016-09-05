ActiveAdmin.register Dealing do

  controller do
    def scoped_collection
      Dealing.includes({book: :seller}, {book: :buyer})
    end
  end

  index do
    selectable_column
    column :book_id
    column "購入者" do |dealing|
      link_to dealing.book.buyer.nickname, admin_user_path(dealing.book.buyer)
    end
    column "出品者" do |dealing|
      if dealing.book.seller.present?
        link_to dealing.book.seller.nickname, admin_user_path(dealing.book.seller)
      end
    end
    column "購入日時" do |dealing|
      dealing.created_at.in_time_zone("Tokyo").strftime("%Y/%m/%d %X")
    end
    actions
  end

  filter :book_title, as: :string, label: "本のタイトル"
  filter :book_buyer_nickname, as: :string, label: "購入者"
  filter :book_seller_nickname, as: :string, label: "出品者"
  filter :created_at, label: "購入日"
end
