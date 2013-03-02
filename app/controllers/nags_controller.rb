class NagsController < ApplicationController
  def new
    @nag = Nag.new
    if current_user
      @graph = Koala::Facebook::API.new(current_user.oauth_token)
      @friends = @graph.get_connections("me", "friends")
    end
  end

  def create
    @nag = Nag.new params[:nag]
    if @nag.save
      redirect_to root_url, notice: "Nag created!"
    else
      render 'new'
    end
  end

  def edit
    @nag = Nag.find_by_id params[:id]
  end

  def update
    @nag = Nag.find_by_id params[:id]
    @nag.update_attributes params[:nag]

    if @nag.save
      redirect_to root_url, notice: "nag updated!"
    else
      render 'edit'
    end
  end

  def destroy
    @nag = Nag.find_by_id params[:id]
    @nag.destroy
    redirect_to root_url, notice: "nag destroyed!"
  end

  def show
    @nag = Nag.find_by_id params[:id]
  end
end
