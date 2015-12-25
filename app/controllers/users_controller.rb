class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def show # 追加
   @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "update succeed"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :area, :profile)
  end
end
