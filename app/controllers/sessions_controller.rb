class SessionsController < ApplicationController

  def new
     if current_user
      redirect_to user_url(current_user.id, filter: params[:filter], id: current_user.id)
    end
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to user_url(session[:user_id]), notice: 'Logged in'
  end

  def destroy
    reset_session
    redirect_to login_url, notice: 'Come back soon!'
  end
end
