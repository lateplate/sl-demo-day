OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '521194684598530', 'a58fbed7c39dc194038dab093c81e7ae',
   		  {scope: "xmpp_login , read_stream"}

	def redirect_to_failure
	  message_key = env['omniauth.error.type']
	  new_path = "#{env['SCRIPT_NAME']}#{OmniAuth.config.path_prefix}/failure?message=#{message_key}"
	  Rack::Response.new(["302 Moved"], 302, 'Location' => new_path).finish
	end
end

# FACEBOOK_APP_ID='521194684598530'
# FACEBOOK_SECRET='a58fbed7c39dc194038dab093c81e7ae'
