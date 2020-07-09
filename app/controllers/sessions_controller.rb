class SessionsController < ApplicationController
  before_action :require_user, only: [:destroy]
  before_action :require_no_user, only: [:new, :create]

  def new  
  end

  def create
    user = User.where(email: user_params[:email]).first
    
    if user && user.authenticate(user_params[:password])
      session[:user_id] = user.id
      flash[:success] = "You've been logged in!"
      redirect_to root_path
    else
      flash[:error] = "The login details were invalid!"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've logged out."
    redirect_to root_path
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
