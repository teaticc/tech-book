class BooksController < ApplicationController
  def index
    @books = Book.all
    @categories = ActsAsTaggableOn::Tag.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def search
    if params[:category].empty?
      @books = Book.where("title LIKE ?", "%#{params[:keyword]}%")
    else
      @books = Book.tagged_with(params[:category])
      if params[:keyword].present?
        @books = @books.where("title LIKE ?", "%#{params[:keyword]}%")
      end
    end
    @searcher = { category: params[:category], keyword: params[:keyword] }
    @categories = ActsAsTaggableOn::Tag.all
  end
end
