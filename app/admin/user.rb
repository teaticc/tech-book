ActiveAdmin.register User do
  index do
    selectable_column

    column :nickname do |user|
      link_to user.nickname, admin_user_path(user)
    end
    column "メールアドレス", :email
    column "ログイン回数", :sign_in_count
    actions
  end

  filter :nickname
  filter :email, label: "メールアドレス"
  filter :sign_in_count, label: "ログイン回数"
end
