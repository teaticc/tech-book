class AddressesController < ApplicationController
  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to :back, flash: { notice: ["購入者情報を更新しました"] }
    else
      redirect_to :back, flash: { error: "" }
    end
  end

  def address_params
    params.require(:address).permit(:family_name, :first_name, :post_number, :street_address)
  end
end
