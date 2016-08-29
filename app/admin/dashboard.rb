ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: "管理TOP"

  # index as: :grid do
  #   Book.all.each do |book|
  #     link_to image_tag(book.image.url(:thumb)), admin_book_path(book)
  #   end
  # end

  content title: "管理TOP" do

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

  sidebar :help do
    "test"
  end
end
