class BooksController < ApplicationController
  
  def new
    @book = Book.new
  end
  

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to books_path
  end
  
  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end
  
  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    redirect_to book_path(@book.id)
  end
  
  
  

  def index
    @book_list = Book.new
    @books = Book.all
    @user_list = current_user
  end
  
  

  def show
    @book = Book.find(params[:id])
    @book_list = Book.new
    @user_list = @book.user
  end
  
  

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end
  
  
  
end
