class SessionsController < ApplicationController
  include SessionsHelper

  def new
  end

  # action for login user and set in session user_id
  def create
    @user = User.find_by_email(params[:session][:email])

    if @user && !@user.activated
      flash.now[:danger] = I18n.t 'error_msg_not_activated'
      render :new
    elsif @user && @user.authenticate(params[:session][:password])
      log_in@user
      remember @user    if params[:session][:remember_me] == '1'
      redirect_to root_path
    else
      flash.now[:danger] = I18n.t 'error_msg_auth'
      render :new
    end
  end

  # action logout user delete auth user_id and redirect to root
  def destroy
    log_out
    redirect_to login_path
  end
end
