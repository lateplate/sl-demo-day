class SessionsController < ApplicationController

  def new
     if current_user
      redirect_to user_url(current_user.id, filter: params[:filter], id: current_user.id)
    end
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url
  end

  def destroy
    reset_session
    redirect_to root_url
  end
end
