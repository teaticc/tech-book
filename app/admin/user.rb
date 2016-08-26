ActiveAdmin.register User do
  index do
    selectable_column

    column :id do |user|
      link_to user.id, admin_user_path(user)
    end
    column :nickname do |user|
      link_to user.nickname, admin_user_path(user)
    end
    column :email
    column :sign_in_count
  end

end
