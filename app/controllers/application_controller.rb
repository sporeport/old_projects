class ApplicationController < ActionController::Base
  protect_from_forgery

  def log_in!(user)
    user.reset_token
    session[:session_token] = user.session_token
  end

  def log_out!(user)
    user.reset_token
    session[:session_token] = nil
  end

end
