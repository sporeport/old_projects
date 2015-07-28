class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(
      session_params[:email],
      session_params[:password]
    )

    if @user
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:danger] = ["Incorrect email/password combination"]
      @user = User.new(session_params)
      render :new
    end
  end

  def destroy
    temp = current_user
    logout!(current_user)
    flash[:notice] = ["#{temp.user_name} has logged out"]
    redirect_to root_url
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
