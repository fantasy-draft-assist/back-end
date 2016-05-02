class YahooImporter

	def initialize(api)
		@api = api
		@count = 0
	end

	def scrape_stats(seasons, max_player_id)
		while @count < max_player_id
			if @api.token_expires_at <= DateTime.now + 2.minutes
				@api.refresh_token!
			elsif (@count % 2500).zero?
				sleep 10.minutes
			else
				@count += 1
				seasons.each do |season|
					data = @api.pull_stats(season, @count)
					next unless data
					Player.import_from_json(data) #or dump to file??
					sleep 0.5.seconds
				end
			end
		end
	end
end

				