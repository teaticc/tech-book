class DealingsController < ApplicationController
  def new
    @book = Book.find(params[:book_id])
    @dealing = Dealing.new
    if current_user.address.present?
      @dealing.build_address(current_user.address.attributes.except("id", "created_at", "updated_at"))
    else
      @dealing.build_address
    end
  end

  def create
    @dealing = Dealing.new(dealing_params)
    if @dealing.save
      @address = @dealing.address
      @book = @dealing.book
      @book.update_attributes(buyer_id: current_user.id)
      user_address_check
      DealingMailer.dealing_email(@book, @address).deliver_now
    else
      redirect_to :back, flash: { error: @dealing.errors.full_messages }
    end
  end

  private
  def dealing_params
    params.require(:dealing).permit(:registered, address_attributes: [:family_name, :first_name, :order_email, :phone_number, :post_number, :street_address]).merge(book_id: params[:book_id])
  end

  def user_address_check
    if current_user.address.blank?
      binding.pry
      current_user.create_address(@address.attributes.except("id", "created_at", "updated_at"))
    end
  end
end
