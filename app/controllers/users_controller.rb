class UsersController < ApplicationController
  before_action :require_no_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "The user was registered! You have been logged on!"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:error] = "The user was not registered!"
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
