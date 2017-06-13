class SessionsController < ApplicationController
  include SessionsHelper

  def new
  end

  # action for login user and set in session user_id
  def create
    @user = User.find_by_email(params[:session][:email])

    if @user && !@user.activated
      flash.now[:danger] = 'Email not activated'
      redirect_to login_path
    elsif @user && @user.authenticate(params[:session][:password])
      log_in@user
      remember @user    if params[:session][:remember_me] == '1'
      redirect_to '/'
    else
      flash.now[:danger] = 'Invalid email/password combination'
      # redirect_to '/login'
      redirect_to signup_path
    end
  end

  # action logout user delete auth user_id and redirect to root
  def destroy
    log_out
    redirect_to '/'
  end
end
