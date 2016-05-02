require 'uri'
require 'net/http'

class YahooApi

	OAUTH_BASE_URI = "https://api.login.yahoo.com/oauth2"
	REDIR_BASE_URI = "https://hockeydoctor.herokuapp.com"

	def initialize(user)
		@user = user
		@headers = {
			"Authorization: Bearer" => @user.y_access_token
		}
	end

	## FANTASY SPORTS API CALLS

	# kinda like this: 
	# HTTParty.get("path/for/fantasy/sports/thing", query: whatever, headers: @headers)

	def get_player_stats(player_key)
		url = URI("https://fantasysports.yahooapis.com/fantasy/v2/player/#{player_key}/stats?format=json")
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		request = Net::HTTP::Get.new(url)
		request["Authorization"] = "#{@user.y_access_token}"
		request["cache-control"] = 'no-cache'
	    request["content-type"] = 'application/x-www-form-urlencoded'
		response = http.request(request)
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
	  url = URI("#{OAUTH_BASE_URI}/get_token")
	  http = Net::HTTP.new(url.host, url.port)
	  http.use_ssl = true
	  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	  request = Net::HTTP::Post.new(url)
	  request["authorization"] = "Basic #{auth64_header}"
	  request["cache-control"] = 'no-cache'
	  request["content-type"] = 'application/x-www-form-urlencoded'
	  request.body = "code=#{code}&client_id=dj0yJmk9ck1TZjRhNWM2b0NmJmQ9WVdrOVZFSTViME5JTkRJbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD03Mg--&client_secret=67d5c2b40befd3558b38e5f54c440def6875c6a7&redirect_uri=oob&grant_type=authorization_code"
	  response = http.request(request)
	  update_user_token(response)
	end

	def refresh_token!
		if @user.y_expires_at <= DateTime.now
			params = oauth_params('refresh_token')
			params.merge!({ "refresh_token": @user.y_refresh_token })
			response = HTTParty.post("#{OAUTH_BASE_URI}/get_token", body: params,
					headers: oauth_headers)
			update_user_token(response)
		end
	end

	private
	def update_user_token(response)
		data = JSON.parse(response.body)
		token = "Bearer #{data["access_token"]}"
		@user.update(y_access_token: token,
			y_token_type: data["token_type"],
			y_refresh_token: data["refresh_token"])
		if data["expires_in"].present?
			@user.update(y_expires_at: DateTime.now + data["expires_in"].seconds)
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

	def auth64_header
		client_id = ENV["YAHOO_CLIENT_ID"]
		secret_id = ENV["YAHOO_SECRET_ID"]
		Base64.encode64("#{client_id}:#{secret_id}")
	end
end