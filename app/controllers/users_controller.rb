class UsersController < ApplicationController

  before_action :require_user, only: [:home]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
    redirect_to "/"
  end

  def home
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :company, :phone)
  end

end
