module Search
  extend ActiveSupport::Concern
  def books_search
    reject_sold
    category_search
    cross_column_search
  end

  def custom_search
    reject_sold
    category_search
    price_search
    search_keys = ["title", "author"]
    search_keys.each do |key|
      single_search(key)
      set_searcher(key)
    end
  end

  private
  def reject_sold
    @books = @books.where(buyer_id: nil) if params[:reject_sold] == "yes"
  end

  def category_search
    @books = @books.tagged_with(params[:category]) if params[:category].present?
  end

  def price_search
    if params[:min_price].present? || params[:max_price].present?
      min = params[:min_price].to_i
      max = params[:max_price].to_i
      max = 1000000 if max == 0
      @books = @books.where(price: min...max)
      set_searcher("min_price")
      set_searcher("max_price")
    end
  end

  def single_search(key)
    @books = @books.where("#{key} LIKE '%#{params[key]}%'") if params[key].present?
  end

  def cross_column_search
    if params[:keyword].present?
      keyword = params[:keyword]
      @books = @books.where("title LIKE '%#{keyword}%' or author LIKE '%#{keyword}%' or detail LIKE '%#{keyword}%'")
      set_searcher(keyword)
    end
  end

  def set_searcher(key)
    @searcher = @searcher.merge(key => params[key])
  end
end
