class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_oauth_token

  def check_oauth_token
  		user = User.find session[:user_id] if session[:user_id]
  		if user.blank? || Time.now > user.oauth_expires_at
  			redirect_to login_url
  		end
  end

  private

	def current_user
	  @current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
	helper_method :current_user
end
