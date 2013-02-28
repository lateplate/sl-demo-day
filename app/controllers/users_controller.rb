class UsersController < ApplicationController
  def show
  	@nags = current_user.nags
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
end
