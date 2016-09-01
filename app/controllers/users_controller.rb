class UsersController < ApplicationController
  include Common
  before_action :login_check, only: [:show, :edit]
  before_action :return_others, only: [:show, :edit]
  before_action :set_user

  def show
  end

  def edit
    @address = Address.where(addressable_id: @user.id, addressable_type: User).first_or_create
  end

  private
  def set_user
    @user = User.find(current_user.id)
  end

  def return_others
    redirect_to :back unless params[:id] == current_user.id.to_s
  end
end
