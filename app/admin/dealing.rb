ActiveAdmin.register Dealing do

  scope :all, default: true
  scope "支払い未確認" do |dealings|
    dealings.where(paid: false)
  end

  controller do
    def scoped_collection
      Dealing.includes({book: :seller}, {book: :buyer})
    end
  end

  batch_action :toggle_paid do |ids|
    Dealing.find(ids).each do |dealing|
      dealing.toggle :paid
      dealing.save
    end
    redirect_to collection_path
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
    column "支払い方法" do |dealing|
      dealing.payment == "credit_card" ? "カード" : "銀行振込"
    end
    column("支払い") { |dealing| status_tag(dealing.paid) }
    actions
  end

  filter :book_title, as: :string, label: "本のタイトル"
  filter :book_buyer_nickname, as: :string, label: "購入者"
  filter :book_seller_nickname, as: :string, label: "出品者"
  filter :created_at, label: "購入日"
end
