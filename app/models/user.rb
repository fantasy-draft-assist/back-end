class User < ActiveRecord::Base
	has_secure_password

	#has_many fantasyteams
	#has_many leagues
	#has_many drafts

	validates :email, presence: true, uniqueness: true,
		format: {
			with: /.+\@.+\.+/,
			message: "USE VALID EMAIL FORMAT."
		}
	validates_presence_of :auth_token, 

	def ensure_auth_token
		unless self.auth_token
			self.auth_token = User.generate_token
		end
	end

	def self.generate_token
		token = SecureRandom.hex
		while User.exists?(auth_token: token)
			token = SecureRandom.hex
		end
		token
	end

	def maybe_refresh_token!
		if self.expires_at <= DateTime.now
			response = HTTParty.post("", body: { refresh_token: "whatever"} )
			self.update(y_access_token: response["access_token"])
		end
	end
end

