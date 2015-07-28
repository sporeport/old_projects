class UsersController < ApplicationController
  def index
    @users = User.all
    render :index
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def new
    if logged_in?
      flash[:errors] = "Cannot create a user while logged in"
      redirect_to users_url
    else
      @user = User.new
      render :new
    end
  end

  def create
    @user = User.new(user_params)

    if logged_in?
      flash[:errors] = "Cannot create a user while logged in"
      redirect_to users_url
    elsif @user.save
      log_in_user!(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
