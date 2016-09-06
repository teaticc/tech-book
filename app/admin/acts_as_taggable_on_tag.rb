ActiveAdmin.register ActsAsTaggableOn::Tag do
  index do
    selectable_column

    column "カテゴリー名", :name
    column "カテゴリーに属する本の数", :taggings_count
    actions
  end

  sidebar :admin_menu, priority: 0, partial: "admin/menu"

end
