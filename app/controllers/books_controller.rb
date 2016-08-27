class BooksController < ApplicationController
  def index
    @books = Book.order(created_at: :desc)
    @categories = ActsAsTaggableOn::Tag.order(taggings_count: :desc)
  end

  def show
    @book = Book.find(params[:id])
    @related_books = Book.tagged_with(@book.category_list, any: true).uniq.page(params[:page])
    binding.pry
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
    @categories = ActsAsTaggableOn::Tag.all.order(taggings_count: :desc)
    @books = @books.page(params[:page])
  end
end
