class StaticPagesController < ApplicationController
  def index
    if current_user
      redirect_to user_url(current_user)
    end
  end

  def new
  end

  def details
  end
end
