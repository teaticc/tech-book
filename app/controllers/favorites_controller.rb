class FavoritesController < ApplicationController
  before_action :set_book
  def create
    @book.favorites.create(user_id: current_user.id)
  end

  def destroy
    @book.favorites.find_by(user_id: current_user.id).destroy
    set_book
  end

  private
  def set_book
    @book = Book.find(params[:book_id])
  end
end
