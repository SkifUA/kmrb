class Admin::BaseController < ApplicationController
  layout "admin"
  before_action :require_admin

  def superadmin?
    return false unless session[:user_id]
    return false unless Admin.exists?(user_id: session[:user_id], role: Admin::SUPERADMIN)
    true
  end

  def require_admin
    redirect_to '/login' unless admin?
  end

end
