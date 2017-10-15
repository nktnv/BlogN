class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    redirect_to '/login' unless current_user
  end

  def redirect_non_owner_user(obj)
    redirect_to '/' unless user_owner_of?(obj)
  end

end
