class YahooApi
	include HTTParty
	require 'uri'

	OAUTH_BASE_URI = URI("https://api.login.yahoo.com/oauth2")
	REDIR_BASE_URI = URI("https://hockeydoctor.herokuapp.com")

	def initialize(user)
		@user = user
		@headers = {
			"Authorization: Bearer" => @user.y_access_token
		}
	end

	## FANTASY SPORTS API CALLS

	# kinda like this: 
	# HTTParty.get("path/for/fantasy/sports/thing", query: whatever, headers: @headers)

	def get_player_data
		## https://developer.yahoo.com/fantasysports/guide/player-resource.html#player-resource-desc
	end


	## OAUTH API CALLS

	def oauth_request_url
		options = {
			client_id: ENV["YAHOO_CLIENT_ID"],
			response_type: "code",
			redirect_uri: "#{REDIR_BASE_URI}/oauth/#{@user.id}/authorize"
		}
		"#{OAUTH_BASE_URI}/request_auth?#{options.to_query}"
	end

	def oauth_get_token(code)
		params = oauth_params('authorization_code')
		params.merge!({ "code": code })
		response = HTTParty.post("#{OAUTH_BASE_URI}/get_token", body: URI.encode_www_form(params),
			headers: oauth_headers)
		update_user_token(response)
	end

	def refresh_token!
		if @user.y_expires_at <= DateTime.now
			params = oauth_params('refresh_token')
			params.merge!({ "refresh_token": @user.y_refresh_token })
			response = HTTParty.post("#{OAUTH_BASE_URI}/get_token", body: URI.encode_www_form(params),
					headers: oauth_headers)
			update_user_token(response)
		end
	end

	private
	def update_user_token(response)
		@user.update(y_access_token: response["access_token"],
			y_token_type: response["token_type"],
			y_refresh_token: response["refresh_token"])
		if response["expires_in"].present?
			@user.update(y_expires_at: DateTime.now + response["expires_in"].seconds)
		else
			Rails.logger.warn "No Expiration data in response: \n#{response}\n\n"
		end
	end

	def oauth_params(grant_type)
		{
			client_id: ENV["YAHOO_CLIENT_ID"],
			client_secret: ENV["YAHOO_SECRET_ID"],
			redirect_uri: "oob", #{heroku app}
			grant_type: grant_type
		}
	end

	def oauth_headers
		client_id = ENV["YAHOO_CLIENT_ID"]
		secret_id = ENV["YAHOO_SECRET_ID"]
		encoded = Base64.encode64("#{client_id}:#{secret_id}")
		{
			"Authorization" => "Basic #{encoded}",
		}
	end
end