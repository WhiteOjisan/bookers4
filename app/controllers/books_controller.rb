class BooksController < ApplicationController
  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
  end

  def show
    @user = current_user
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @user = current_user
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "successfully created"
      redirect_to book_path(@book.id)
    else
      render :index
    end
  end

  def edit
    @books = Book.all
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "successfully updated"
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = "successfully deleted"
    redirect_to user_path(current_user.id)
  end

  private

    def book_params
      params.require(:book).permit(:title, :body, :user_id)
    end

end
