class UsersController < ApplicationController
  def show
    @nags = Nag.where(user_id: current_user.id).order('due_date asc')
    if params[:filter].present?
      @nags = Nag.filter params[:filter]
    end
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
