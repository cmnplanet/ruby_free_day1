class BooksController < ApplicationController
  # before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /books
  # GET /books.json
  def index
    @book = Book.all
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.find(params[:id])
  end


  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    @book.user = current_user
    if @book.save
      redirect_to @book
    else
      render 'new'
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    @book = Book.find(params[:id])
    if @book.user == current_user
      if @book.update(book_params)
        redirect_to @book
      else
        render 'edit'
      end
    else
      redirect_to root
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    if @book.destroy
      redirect_to books_path
    else
      redirect_to root
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :author, :synopsis, :url)
    end
end
