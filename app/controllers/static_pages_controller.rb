class StaticPagesController < ApplicationController

  def index
    if current_user
      redirect_to user_url(current_user.id, filter: params[:filter], id: current_user.id)
    end
  end

# What does this method do? Do we need it?
  def new
  end

# What does this method do? Do we need it?s
  def details
  end
end
