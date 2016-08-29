ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: "管理TOP"

  content title: "管理TOP" do |books|
    panel "本一覧" do
      render partial: "admin/booksGrid", locals: { books: Book.all.limit(12) }
    end
    columns do
      column do
        panel "出品中の本" do
          table_for Book.where(buyer_id: nil) do
            column("タイトル") { |book| link_to book.title, admin_book_path(book) }
            column("出品者") { |book| link_to book.seller, admin_user_path(book.seller) if book.seller.present? }
            column("値段") { |book| "#{book.price}円" }
          end
        end
      end

      column do
        panel "最近の取引" do
          table_for Dealing.order(id: :desc).limit(10) do
            column("タイトル") {|dealing| link_to dealing.book.title, admin_book_path(dealing.book) }
            column("購入者") { |dealing| link_to dealing.book.buyer.nickname, admin_user_path(dealing.book.buyer) }
            column("出品者") { |dealing| link_to dealing.book.seller.nickname, admin_user_path(dealing.book.seller) if dealing.book.seller.present? }
          end
        end
      end
    end
  end # content
  sidebar "メニュー" do
    render "admin/menu"
  end
end
