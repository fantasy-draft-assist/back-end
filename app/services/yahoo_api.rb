class YahooApi

	OAUTH_BASE_URI = "https://api.login.yahoo.com/oauth2"
	REDIR_BASE_URI = "https://hockeydoctor.herokuapp.com"
	YAHOO_BASE_URI = "https://fantasysports.yahooapis.com/fantasy/v2"

	STATS_MAP = {
		0  => "games_played",
		1  => "goals",
		2  => "assists",
		3  => "points",
		4  => "plus_minus",
		5  => "penalty_minutes",
		6  => "powerplay_goals",
		7  => "powerplay_assists",
		8  => "powerplay_points",
		9  => "shorthanded_goals",
		10 => "shorthanded_assists",
		11 => "shorthanded_points",
		12 => "game_winning_goals",
		14 => "shots_on_goal",
		15 => "shot_percentage",
		16 => "faceoffs_won",
		17 => "facoffs_lost",
		18 => "games_started",
		19 => "wins",
		20 => "losses",
		22 => "goals_against",
		23 => "goals_against_average",
		24 => "shots_against",
		25 => "saves",
		26 => "save_percentage",
		27 => "shutouts",
		28 => "minutes_played",
		31 => "hits",
		32 => "blocks"
	}

	def initialize(user)
		@user = user
	end

	## IMPORTER METHODS

	def token_expires_at
		@user.y_expires_at
	end

	def pull_stats(season_id, player_id)
		data = self.get_player_stats(season_id, player_id)
		return nil if data.has_key?("error")
		player_array = data["fantasy_content"]["player"][0]
		stats_array = data["fantasy_content"]["player"][1]["player_stats"]["stats"]
		player_data = flatten_hashes(player_array)
		stats_data = hashify_stats(stats_array)

		result = {}
		Rails.logger.info "Player_data is #{player_data}\n\nStats_data is #{stats_data}\n\nResult is #{result}\n\n"
		result["player_name"] = player_data["name"]["full"]
		result["yahoo_player_id"] = player_data["player_id"]
		result["uniform_number"] = player_data["uniform_number"]
		result["headshot_url"] = player_data["headshot"]["url"]
		result["positions"] = player_data["eligible_positions"][0]["position"]
		result["pro_team"] = {}
		result["pro_team"]["name"] = player_data["editorial_team_full_name"] # TODO
		result["pro_team"]["abbreviation"] = player_data["editorial_team_abbr"] # TODO
		result["pro_team"]["yahoo_team_id"] = player_data["editorial_team_key"] # TODO
		result["pro_player"]["season"] = stats_data[0]["season"] # TODO
		result["player_stats"] = stats_data

		Rails.logger.info "The resulting mess is #{result}"

		result
	end

	## FANTASY SPORTS API CALLS !

	def get_player_stats(game_key, player_key)
		Rails.logger.warn "pulling player #{game_key}, #{player_key}"
		response = HTTParty.get("#{YAHOO_BASE_URI}/player/#{game_key}.p.#{player_key}/stats",
			query: { format: "json" }, headers: request_headers)
	end

	def get_league_players(game_key, league_key)
		response = HTTParty.get("#{YAHOO_BASE_URI}/league/#{game_key}.l.#{league_key}/players",
			query: { format: "json" }, headers: request_headers)
	end

	def get_team_players(game_key, league_key, team_key)
		response = HTTParty.get("#{YAHOO_BASE_URI}/team/#{game_key}.l.#{league_key}.t.#{team_key}/roster/players",
			query: { format: "json" }, headers: request_headers)
	end

	def get_transactions(game_key, league_key)
		response = HTTParty.get("#{YAHOO_BASE_URI}/league/#{game_key}.l.#{league_key}/transactions",
			query: { format: "json" }, headers: request_headers)
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
		params = oauth_params("authorization_code")
		Rails.logger.warn"code:#{code}   params:#{params}"
		params.merge!({ "code": code })
		response = HTTParty.post("#{OAUTH_BASE_URI}/get_token", body: params,
	  		headers: oauth_headers)
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
	def hashify_stats(stats)
		result = {}

		stats.each do |stat|
			stat_key = stat["stat"]["stat_id"].to_i
			result_key = STATS_MAP[stat_key]
			value = stat["stat"]["value"]
			if result_key
				result[result_key] = value
			end
		end

		result
	end

	def flatten_hashes(hashes)
		Rails.logger.info "The unflattened hash is #{hashes}"
		result = {}
		hashes.each do |hash|
			result.merge!(hash) if hash.is_a?(Hash)
		end
		Rails.logger.info "The flattened hash is #{result}"
		result
	end

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

	def request_headers
		{
			"Authorization" => @user.y_access_token
		}
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
		encoded = Base64.encode64("#{client_id}:#{secret_id}").gsub("\n", '')
		{
			"Authorization" => "Basic #{encoded}"
		}
	end
end