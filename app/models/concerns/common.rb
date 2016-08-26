module Common
  extend ActiveSupport::Concern
  def login_check
    redirect_to root_path, flash: { alert: ["ログインまたは新規登録してください"] } unless user_signed_in?
  end
end
