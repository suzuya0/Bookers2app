class UsersController < ApplicationController
  
  def index
    @book_list = Book.new
    @users = User.all
    @user_list = current_user
  end 
  
  
  
  def show
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
    @book_list = Book.new
  end
  
  
  def edit
   @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  
  
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
    
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name,:profile_image)
  end
  
  
end
