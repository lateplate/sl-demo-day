class User < ActiveRecord::Base
  attr_accessible :email, :name, :oauth_expires_at, :oauth_token, :provider, :uid

  has_many :nags, dependent: :destroy

	def self.from_omniauth(auth)
	  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
	    user.provider = auth.provider
	    user.uid = auth.uid
	    user.name = auth.info.name if user.name.blank?
	    user.email = auth.info.email if user.email.blank?
	    user.oauth_token = auth.credentials.token
	    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
	    user.save!
	  end
	end
end
