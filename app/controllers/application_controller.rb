class ApplicationController < ActionController::Base
  include SessionsHelper

  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :admin?

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    elsif (user_id = cookies.signed[:user_id])
      user = User.find(user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def require_user
    redirect_to '/login' unless current_user
  end

  def admin?
    return false unless session[:user_id]
    return false unless Administrator.exists?(user_id: session[:user_id])
    true
  end

  def superadmin?
    return false unless session[:user_id]
    return false unless Administrator.exists?(user_id: session[:user_id], role: Administrator::SUPERADMIN)
    true
  end

  def require_admin
    redirect_to '/login' unless admin?
  end

end
