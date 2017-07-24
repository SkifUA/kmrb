class UsersController < ApplicationController

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
      flash[:info] = I18n.t 'users.success.create'
      redirect_to home_path
    else
      flash.now[:danger] = I18n.t 'users.error.create'
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash.now[:info] = I18n.t "users.success.update"
      render 'show'
    else
      flash.now[:danger] = I18n.t 'users.error.update'
      render 'edit'
    end
  end


  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
