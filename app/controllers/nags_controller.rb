class NagsController < ApplicationController


  before_filter :authorize_user, except: [:send_nags, :send_mail, :remind, :new, :create]

  def authorize_user
    @nag=Nag.find_by_id(params[:id])
    if @nag.blank? || @nag.user_id != session[:user_id]
      redirect_to root_url
    end
  end

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
    if current_user
      @graph = Koala::Facebook::API.new(current_user.oauth_token)
      @fb_friends = @graph.get_connections("me", "friends")
      @friends_with_id = @fb_friends.map { |friend| {name: friend['name'], id: friend['id']}}.to_json
    end
  end

  def update
    @nag = Nag.find_by_id params[:id]
    @nag.update_attributes params[:nag]

    if @nag.save
      redirect_to nag_url(@nag), notice: "nag updated!"
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
    redirect_to(root_url) if @nag.blank?
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

  def remind
    @nag = Nag.find_by_id params[:id]
    @nag.send_fb_message(current_user.oauth_token)
    redirect_to nag_url(@nag), notice: "Nag sent"
  end

  def index
    redirect_to root_url
  end
  def borrower
  end
end
