class Books::SearchController < ApplicationController

  def database
    books_search
    @searcher = { category: params[:category], keyword: params[:keyword] }
    @categories = ActsAsTaggableOn::Tag.all.order(taggings_count: :desc)
  end

  def amazon
    
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
