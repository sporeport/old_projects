class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(
                    params[:user][:username],
                    params[:user][:password])

    if @user
      log_in!(@user)
      redirect_to user_url(@user)
    else
      @user = User.new(username: params[:user][:username])
      flash.now[:errors] = ["Invalid username or password"]
      render :new
    end
  end

  def destroy
    log_out!
    redirect_to session.delete(:return_to)
  end
end
