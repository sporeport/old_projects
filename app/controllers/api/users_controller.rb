class Api::UsersController < ApplicationController

  def show
    @user = User.find_by_credentials(params[:username], params[:password])

    if @user
      render :show
    else
      render status: :not_found
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render :show
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def current_user
    @user = User.find_by(session_token: params[:session_token])
    if @user
      render :show
    else
      render status: :not_found
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
