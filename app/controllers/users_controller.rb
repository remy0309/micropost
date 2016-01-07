class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :followings, :followers]
  before_action :authorize!, only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def show
    @microposts = @user.microposts.order(created_at: :desc)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Your account has been created"
      session[:user_id] = @user.id
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "update succeed"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def followings
    @followings = @user.following_users
  end
  
  def followers
    @followers = @user.follower_users
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def authorize!
    if @user != current_user
      redirect_to root_url, alert: "不正なアクセス"
    end
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :area, :profile)
  end
end
