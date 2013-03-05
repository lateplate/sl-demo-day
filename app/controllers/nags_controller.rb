class NagsController < ApplicationController
  def new
    @nag = Nag.new
    if current_user
      @graph = Koala::Facebook::API.new(current_user.oauth_token)
      @fb_friends = @graph.get_connections("me", "friends")

      @friends = @fb_friends.map { |friend| "#{friend['name']}"}
      @friends_with_id = @fb_friends.map { |friend| {name: friend['name'], id: friend['id']}}
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

  def send_nags
    @nags = current_user.nags

    @nags.each do |nag|
      unless nag.sent?
        nag.send_fb_message(current_user.oauth_token)
      end
    end
    redirect_to user_url(current_user.id), notice: 'nags sent'
  end

  def send_mail
     @nags = current_user.nags

    @nags.each do |nag|
      unless nag.sent? || !self.lendee_name.include?('@')
        NagMailer.nag_borrower(nag).deliver
        nag.sent = true
        nag.save
      end
    end
        redirect_to root_url
  end
end
