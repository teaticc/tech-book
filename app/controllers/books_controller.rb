class BooksController < ApplicationController
  def index
    @books = Book.order(created_at: :desc).page(params[:page]).includes(:buyer)
    @categories = ActsAsTaggableOn::Tag.order(taggings_count: :desc)
  end

  def show
    @book = Book.find(params[:id])
    @related_books = Book.tagged_with(@book.category_list, any: true)
                         .uniq
                         .where.not(id: @book.id)
                         .includes(:buyer)
                         .page(params[:page])
  end

  def search
    books_search
    @searcher = { category: params[:category], keyword: params[:keyword] }
    @categories = ActsAsTaggableOn::Tag.all.order(taggings_count: :desc)
  end

  private

  def books_search
    if params[:category].present?
      if params[:keyword].present?
        @books = Book.tagged_with(params[:category])
                     .where("title LIKE %#{params[:keyword]}%", "%#{params[:keyword]}%")
                     .includes(:buyer)
                     .page(params[:page])
      else
        @books = Book.tagged_with(params[:category])
                     .includes(:buyer)
                     .page(params[:page])
      end
    else
      @books = Book.where("title LIKE ?", "%#{params[:keyword]}%")
                   .includes(:buyer)
                   .page(params[:page])
    end
    if params[:reject_sold] == "yes"
      @books = @books.where(buyer_id: nil)
    end
  end
end
