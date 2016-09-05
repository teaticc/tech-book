class DealingMailer < ApplicationMailer
  default from: "mailertestforrails@gmail.com"

  def bank_email(book, address)
    @book = book
    @address = address
    mail to: @address.order_email, subject: "ご注文を承りました"
  end

  def credit_email(book, address)
    @book = book
    @address = address
    mail to: @address.order_email, subject: "ご注文を承りました"
  end

  def tell_order(book)
    @book = book
    mail to: @book.seller.email , subject: "#{@book.title}の注文が確定しました"
  end
end
