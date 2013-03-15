class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_oauth_token

  def check_oauth_token
      unless current_user.present? && current_user.has_valid_token?
  			redirect_to login_url, alert: "We logged you out because of inactivity. Login again to resume Nagging."
  		end
  end

  private

	def current_user
	  @current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
	helper_method :current_user
end
