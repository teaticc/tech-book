class DealingsController < ApplicationController
  def new
    @book = Book.find(params[:book_id])
    @dealing = Dealing.new
    @dealing.build_address(current_user.address.attributes)
  end

  def create
    @dealing = Dealing.new(dealing_params)
    unless @dealing.save
      redirect_to new_book_dealing_path(params[:book_id])
    end
    @address = @dealing.address
    @book = @dealing.book
    @book.save(buyer_id: current_user.id)
  end

  private
  def dealing_params
    params.require(:dealing).permit(:registered, address_attributes: [:family_name, :first_name, :order_email, :phone_number, :post_number, :street_address]).merge(book_id: params[:book_id])
  end
end
