class PasswordResetsController < ApplicationController

  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def edit
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email])
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = I18n.t 'success_msg_send_reset_mail'
      redirect_to home_path
    else
      flash.now[:danger] = I18n.t 'error_msg_email_notfound'
      render :new
    end
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "can't be empty")
      render :edit
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = I18n.t 'success_msg_reset_password'
      redirect_to root_path
    else
      flash.now[:danger] = I18n.t 'error_msg_reset_password'
      render :edit
    end
  end

  private
  def get_user
    @user = User.find_by(email: params[:email])
  end

  # Confirms a valid user.
  def valid_user
    unless @user && @user.reset?(params[:id])
      flash[:danger] = "Error key data"
      redirect_to root_url
    end
  end

  # Checks expiration of reset token.
  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = I18n.t 'error_msg_has_expired_reset'
      redirect_to new_password_reset_url
    end
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
