class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def login!(user)
    user.reset_token!
    session[:session_token] = user.session_token

    true
  end

  def logout!(user)
    user.reset_token!
    session[:session_token] = nil

    true
  end

  def current_user
    @current_user ||=
      User.find_by(session_token: session[:session_token])
  end
end
