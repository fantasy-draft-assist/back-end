class YahooImporter

	def initialize(api)
		@api = api
		@count = 35
	end

	def scrape_stats(seasons, max_player_id)
		while @count < max_player_id
			if @api.token_expires_at <= DateTime.now + 2.minutes
				@api.refresh_token!
				Rails.logger.info "New Token?! Token now expires at #{@api.token_expires_at}"
			elsif (@count % 2500).zero? && @count != 0
				sleep 10.minutes
			else
				@count += 1
				seasons.each do |season|
					data = @api.pull_stats(season, @count)
					next unless data
					Player.import_from_json(data) #or dump to file??
					Rails.logger.warn "Playerdata is #{data}"
					sleep 0.5.seconds
				end
			end
		end
	end
end

				