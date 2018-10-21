class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  def current_user
    # find user from session user id
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    redirect_to '/', alert: "Not authorized" if current_user.nil?
  end
  
end
