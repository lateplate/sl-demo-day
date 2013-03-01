class User < ActiveRecord::Base
  attr_accessible :email, :name, :oauth_expires_at, :oauth_token, :provider, :uid

  has_many :nags, dependent: :destroy

	def self.from_omniauth(auth)
	  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
	    user.provider = auth.provider
	    user.uid = auth.uid
	    if user.name.blank?
	    	user.name = auth.info.name
	    end
	    if user.email.blank?
	    	user.email = auth.info.email
	 	 end
	    user.oauth_token = auth.credentials.token
	    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
	    user.save!
	  end
	end
end
