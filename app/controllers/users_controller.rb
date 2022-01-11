class UsersController < ApplicationController

  $cur_usr = nil

  def index
    $cur_usr = current_user
    @users = User.all
    @user = $cur_usr
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    $cur_usr = @user
    @books = Book.all
    @book = Book.new
  end

  def edit
    if $cur_usr == current_user
      @user = User.find(params[:id])
      @book = Book.new
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "successfully updated"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end
end
