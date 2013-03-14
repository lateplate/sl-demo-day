OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["FACEBOOK_APP_ID"], ENV["FACEBOOK_SECRET_KEY"],
        {scope: "email, xmpp_login, read_stream"}

	def redirect_to_failure
	  message_key = env['omniauth.error.type']
	  new_path = "#{env['SCRIPT_NAME']}#{OmniAuth.config.path_prefix}/failure?message=#{message_key}"
	  Rack::Response.new(["302 Moved"], 302, 'Location' => new_path).finish
	end
end

# Orignal settings from Will
# FACEBOOK_APP_ID='521194684598530'
# FACEBOOK_SECRET='a58fbed7c39dc194038dab093c81e7ae'

# localhost setup by Dan
# FACEBOOK_APP_ID='436592866423465'
# FACEBOOK_SECRET='d8e0bf02966a46740a7674d947d3d8e7'
# FACEBOOK_APP_TOKEN ='436592866423465|M35GBwF47W2-xLEVys-n-tyeSws'

# herokuapp.com setup by Dan
# FACEBOOK_APP_ID='224676817673489'
# FACEBOOK_SECRET='dee566d81462e87246a361ef7be382a3'
