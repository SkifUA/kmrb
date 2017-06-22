class UsersController < ApplicationController

  before_action :require_user, only: [:home]

  def index
    redirect_to root_url
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = User::SUCCESS_MESSAGE_CREATE_USER
      redirect_to login_path
    else
      flash.now[:danger] = User::ERROR_MESSAGE_CREATE_USER
      render :new
    end
  end

  def home
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
