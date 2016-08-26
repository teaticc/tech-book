class UsersController < ApplicationController
  include Common
  before_action :login_check, only: [:show]

  def show
    redirect_to :back unless params[:id] == current_user.id
    @user = User.find(current_user.id)
    @address = Address.where(addressable_id: @user.id, addressable_type: User).first_or_create
  end
end
