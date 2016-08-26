ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    columns do
      column do
        panel "出品中の本" do
          ul do
            Book.all.each do |book|
              li link_to(book.title, admin_book_path(book))
            end
          end
        end
      end

      column do
        panel "取引" do
          ul do
            Dealing.all.each do |dealing|
              li link_to(dealing.book.title, admin_dealing_path(dealing))
            end
          end
        end
      end
    end
  end # content
end
