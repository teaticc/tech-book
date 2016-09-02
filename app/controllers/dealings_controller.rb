class DealingsController < ApplicationController
  include Common
  before_action :login_check, :buyer_check

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
    binding.pry
    @dealing = Dealing.new(dealing_params)
    if @dealing.save
      @address = @dealing.address
      @book = @dealing.book
      @book.update_attributes(buyer_id: current_user.id)
      user_address_check
      if params[:dealing][:payment] == "bank_account"
        DealingMailer.bank_email(@book, @address).deliver_now
      else
        pay
        DealingMailer.credit_email(@book, @address).deliver_now
      end
    else
      redirect_to :back, error: @dealing.errors.full_messages, "webpay_token": params["webpay-token"]
    end
  end

  private
  def dealing_params
    params.require(:dealing).permit(:registered, :payment, address_attributes: [:family_name, :first_name, :order_email, :phone_number, :post_number, :street_address]).merge(book_id: params[:book_id])
  end

  def user_address_check
    if current_user.address.blank?
      current_user.create_address(@address.attributes.except("id", "created_at", "updated_at"))
    end
  end

  def buyer_check
    if Book.find(params[:book_id]).buyer.present?
      redirect_to root_path, alert: "この本の取引は終了しました"
    end
  end

  def pay
    binding.pry
    webpay = WebPay.new(ENV["WEBPAY_SECRET"])
    if current_user.customer_id.nil?
      new_customer = webpay.customer.create(
      card: params["webpay-token"],
      email: current_user.email
      )
      current_user.update(customer_id: new_customer.id)
    end
    webpay.charge.create(
      amount: ((@book.price + @book.postage) * 1.080).ceil,
      currency: "jpy",
      customer: current_user.customer_id
      )
  end
end
