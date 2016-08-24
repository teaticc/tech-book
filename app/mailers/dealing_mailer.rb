class DealingMailer < ApplicationMailer
  default from: "support@techbook.com"

  def dealing_email(book, address)
    @book = book
    @address = address
    mail to: @address.order_email, subject: "ご注文を承りました"
  end
end
