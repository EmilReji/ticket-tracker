class ApplicationController < ActionController::Base
  helper_method :current_user, :is_logged_in?

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def is_logged_in?
    !!current_user
  end

  def require_user
    if !is_logged_in?
      flash[:error] = "You must be logged in to do that!"
      redirect_to root_path
    end
  end

  def require_no_user
    if is_logged_in?
      flash[:error] = "You are already logged in as #{current_user.name}. Please logout to do that!"
      redirect_to root_path
    end
  end
end
