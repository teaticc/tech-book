class UsersController < ApplicationController
  def show
    @user = User.find(current_user.id)
    @address = Address.where(addressable_id: @user.id, addressable_type: User).first_or_create
  end
end
