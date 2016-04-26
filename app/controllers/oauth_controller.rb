class OauthController < ApplicationController

	OAUTH_BASE_URI = "https://api.login.yahoo.com/oauth2"

	def new
		@user = User.find(params[:id])
		uri = redirect_for_user(@user.id)
		redirect_to "#{OAUTH_BASE_URI}/request_token?client_id=#{ENV["YAHOO_CLIENT_ID"]}&response_type=code&redirect_uri=#{uri}"
	end

	def create
		code = params[:code]
		@user = User.find(params[:id])
		response = HTTParty.post("#{OAUTH_BASE_URI}/get_token", body: {
				client_id: ENV["YAHOO_CLIENT_ID"],
				client_secret: ENV["YAHOO_SECRET_ID"],
				redirect_uri: "oob", #{heroku app}
				code: code,
				grant_type: 'authorization_code'
			}, headers: {
				"Authorization: Basic" => Base64.encode64("#{ENV['YAHOO_CLIENT_ID']}:#{ENV['YAHOO_SECRET_ID']}")
			})
		@user.update(y_access_token: response["access_token"],
					 y_expires_at: DateTime.now + response["expires_in"].seconds)
		## See Step 4 in Yahoo docs
	end

	private
	def redirect_for_user(id)
		"https://hockeydoctor.herokuapp.com/oauth/#{id}/authorize"
	end

=begin	
def maybe_refresh_token!
  if self.expires_at <= DateTime.now
  	response = HTTParty.post("", body: { refresh_token: "whatever"} )
  	self.update(y_access_token: response["access_token"])
  end
end
=end

end
