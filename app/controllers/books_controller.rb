class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :identify_user, only: [:edit, :update, :destroy]
  before_action :check_dealing, only: [:edit, :update, :destroy]

  def index
    @books = Book.order(created_at: :desc).page(params[:page]).includes(:buyer)
    @categories = ActsAsTaggableOn::Tag.order(taggings_count: :desc)
  end

  def show
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


  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to root_path, notice: "出品しました"
    else
      flash[:error] = @book.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to root_path, notice: "出品内容を変更しました"
    else
      flash[:error] = @book.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @book.destroy
      redirect_to root_path, notice: "出品を取り下げました"
    else
      redirect_to :back, error: "出品の取り下げに失敗しました。先に取引が成立した可能性があります。"
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

  def book_params
    params.require(:book).permit(:title, :price, :postage, :state, :detail, :image).merge(seller_id: current_user.id)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def check_dealing
    if @book.dealing.present?
      redirect_to :back, error: "取引が成立したため変更できませんでした"
    end
  end

  def identify_user
    redirect_to root_path unless current_user.id == @book.seller_id
  end
end
