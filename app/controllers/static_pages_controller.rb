class StaticPagesController < ApplicationController
  def index
    if current_user
      redirect_to user_url(current_user.id, filter: params[:filter], id: current_user.id)
    end
  end

  def new
  end

  def details
  end
end
