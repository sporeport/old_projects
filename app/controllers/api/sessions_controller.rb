class Api::SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(params[:username], params[:password])
  end

  def destroy
  end



end
