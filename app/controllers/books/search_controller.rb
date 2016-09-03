class Books::SearchController < ApplicationController

  def database
    books_search
    @searcher = { category: params[:category], keyword: params[:keyword] }
    @categories = ActsAsTaggableOn::Tag.all.order(taggings_count: :desc)
  end

  def amazon
    if params[:keyword].present?
      books = Amazon::Ecs.item_search(
        params[:keyword], {
          search_index: 'Books',
          dataType: 'script',
          response_group: 'ItemAttributes, Images',
          country: 'jp',
          power: "Not kindle"
        }
      )
      @books = []
      books.items.each do |item|
        book = {
          title: item.get('ItemAttributes/Title'),
          image: item.get('LargeImage/URL'),
          amazon_url: item.get('DetailPageURL')
        }
        @books << book
      end
    end
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
