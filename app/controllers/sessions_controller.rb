class SessionsController < ApplicationController

  skip_before_filter :check_oauth_token, :only => [:new, :create]

  def new
     if current_user && current_user.has_valid_token?
      redirect_to user_url(current_user.id, filter: params[:filter], id: current_user.id)
    end
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to user_url(session[:user_id]), notice: "Signed in"
  end

  def destroy
    reset_session
    redirect_to login_url, notice: 'Signed out successfully'
  end
end
