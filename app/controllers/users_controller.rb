class UsersController < ApplicationController
  include Common
  before_action :login_check, only: [:show, :edit]
  before_action :return_others, only: [:show, :edit]

  def show
    @user = User.includes({buyer_books: :dealing}, {favorite_books: :buyer}).find(current_user.id)
  end

  def edit
    @user = User.includes({buyer_books: :dealing}).find(current_user.id)
    @address = Address.where(addressable_id: @user.id, addressable_type: User).first_or_create
  end

  private
  def return_others
    redirect_to root_path unless params[:id] == current_user.id.to_s
  end
end
