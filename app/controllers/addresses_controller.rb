class AddressesController < ApplicationController
  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to user_path(current_user)
  end

  def address_params
    params.require(:address).permit(:family_name, :first_name, :post_number, :street_address)
  end
end
