require 'uri'
require 'net/http'

class YahooApi
	include HTTParty


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
	  # params = oauth_params("authorization_code")
	  # Rails.logger.warn"code:#{code}   params:#{params}"
	  # params.merge!({ "code": code })
	  # response = HTTParty.post("#{OAUTH_BASE_URI}/get_token", body: params,
	  # headers: oauth_headers)
	  # update_user_token(response)

	  url = URI("#{OAUTH_BASE_URI}/get_token")

	  http = Net::HTTP.new(url.host, url.port)
	  http.use_ssl = true
	  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

	request = Net::HTTP::Post.new(url)
	request["authorization"] = 'Basic ZGoweUptazljazFUWmpSaE5XTTJiME5tSm1ROVdWZHJPVlpGU1RWaU1FNUpUa1JKYldOSGJ6bE5RUzB0Sm5NOVkyOXVjM1Z0WlhKelpXTnlaWFFtZUQwM01nLS06NjdkNWMyYjQwYmVmZDM1NThiMzhlNWY1NGM0NDBkZWY2ODc1YzZhNw=='
	request["cache-control"] = 'no-cache'
	#request["postman-token"] = '99b5c58d-3b87-00e3-46f0-184c59282860'
	request["content-type"] = 'application/x-www-form-urlencoded'
	request.body = "code=#{code}&client_id=dj0yJmk9ck1TZjRhNWM2b0NmJmQ9WVdrOVZFSTViME5JTkRJbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD03Mg--&client_secret=67d5c2b40befd3558b38e5f54c440def6875c6a7&redirect_uri=oob&grant_type=authorization_code"

	response = http.request(request)
	Rails.logger.warn "response type = #{response.class}"
	#puts response.read_body
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
		@user.update(y_access_token: response.body[access_token],
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
		Rails.logger.warn "Base64 Code = #{encoded}"
		{
			"Authorization" => "Basic #{encoded}"
		}
	end
end