class SessionsController < ApplicationController
  def new
    if logged_in?
      flash[:errors] = "Silly, you can't log in twice"
      redirect_to users_url
    else
      @user = User.new
      render :new
    end
  end

  def create
    @user = User.find_by(email: session_params[:email])

    if @user.is_password?(session_params[:password])
      log_in_user!(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = "Incorrect log in information"
      render :new
    end
  end

  def destroy
    if current_user
      @user = current_user
      @user.reset_session_token!
      redirect_to users_url
    else
      flash[:error] = "You cannot log out if your not logged in"
      redirect_to users_url
    end
  end

  private
  def session_params
    params.require(:user).permit(:email, :password)
  end
end
