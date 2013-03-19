OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["FACEBOOK_APP_ID"], ENV["FACEBOOK_SECRET_KEY"],
        {scope: "email, xmpp_login"}

	def redirect_to_failure
	  message_key = env['omniauth.error.type']
	  new_path = "#{env['SCRIPT_NAME']}#{OmniAuth.config.path_prefix}/failure?message=#{message_key}"
	  Rack::Response.new(["302 Moved"], 302, 'Location' => new_path).finish
	end
end
