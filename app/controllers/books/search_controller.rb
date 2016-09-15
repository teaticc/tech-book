class Books::SearchController < ApplicationController
  include Search
  def database
    @searcher = { category: params[:category] }
    @categories = ActsAsTaggableOn::Tag.all.order(taggings_count: :desc)
    @books = Book.all.includes(:buyer).page(params[:page])
    case params[:search_type]
    when "custom" then custom_search
    else books_search
    end
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
          author: item.get("ItemAttributes/Author"),
          image: item.get('LargeImage/URL'),
          amazon_url: item.get('DetailPageURL')
        }
        @books << book
      end
    end
  end
end
