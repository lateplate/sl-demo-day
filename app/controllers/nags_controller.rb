class NagsController < ApplicationController


  before_filter :get_nag, only: [:edit, :update, :destroy, :show, :remind, :authorize_user]
  before_filter :authorize_user, except: [:send_nags, :send_mail, :remind, :new, :create]

  def get_nag
    @nag = Nag.find_by_id(params[:id])
  end
  def authorize_user
    if @nag.blank? || @nag.user_id != session[:user_id]
      redirect_to login_url
    end
  end
  def new
    @nag = Nag.new
    @graph = Koala::Facebook::API.new(current_user.oauth_token)
    @fb_friends = @graph.get_connections("me", "friends")
    @fb_friends.sort_by! { |hash| hash['name'] }
    @friends_with_id = @fb_friends.map { |friend| {name: friend['name'], id: friend['id']}}
  end
  def create
    @nag = Nag.new params[:nag]
    if @nag.save
      flash[:notice] = "Nag created"
      redirect_to user_url(current_user), notice: "Nag created"
    else
      render 'new'
    end
  end
  def edit
    @graph = Koala::Facebook::API.new(current_user.oauth_token)
    @fb_friends = @graph.get_connections("me", "friends")
    @fb_friends.sort_by! { |hash| hash['name'] }
    @friends_with_id = @fb_friends.map { |friend| {name: friend['name'], id: friend['id']}}.to_json
  end
  def update
    @nag.update_attributes params[:nag]
    @nag.completed = true if params[:completed] == 'true'
    @nag.completed = false if params[:completed] == 'false'
    if @nag.save
        respond_to do |f|
          f.html { redirect_to nag_url(@nag), notice: "Nag updated" }
          f.js
        end
    else
      render 'edit'
    end
  end
  def destroy
    @nag.destroy
    redirect_to user_url(current_user), notice: "Nag removed"
  end
  def show
  end
  def send_nags
    @nags = current_user.nags
    @nags.each do |nag|
      unless nag.sent?
        nag.send_fb_message(current_user.oauth_token)
      end
    end
    redirect_to user_url(current_user.id), notice: 'Nags sent'
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
        redirect_to user_url(current_user), notice: "Nag emails sent"
  end
  def remind
    @nag.send_fb_message(current_user.oauth_token, params[:message])
    redirect_to nag_url(@nag), notice: "Nag sent"
  end
end
