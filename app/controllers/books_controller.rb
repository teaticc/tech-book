class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
  end

  def search
  end
end
