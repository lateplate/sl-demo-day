class UsersController < ApplicationController

  before_filter :authorize_user

  def authorize_user
    @user = User.find_by_id(params[:id])
    if current_user.blank? || current_user != @user
      redirect_to login_url
    end
  end

  def show
    @nags = Nag.where(user_id: current_user.id)
    @nags = @nags.filter params[:filter]
  end

  def edit
  end

  def update
  	if current_user.update_attributes params[:user]
  		redirect_to user_url(current_user), notice: "Successfully updated your settings"
  	else
  		render 'edit'
  	end
  end

  def destroy
  end

  def index
  end

  def new
  end

  def create
  end
end
