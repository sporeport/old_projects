class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user

  def logged_in?
    !!current_user
  end

  def log_in!(user)
    session[:session_token] = user.reset_token
  end

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def log_out!
    session[:return_to] ||= request.referer
    current_user.reset_token
    session[:session_token] = nil
  end
end
