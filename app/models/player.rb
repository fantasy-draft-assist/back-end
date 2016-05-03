class Player < ActiveRecord::Base
	has_many :pro_players
	has_many :pro_teams, through: :pro_players
	has_many :player_stats, through: :pro_players

	def full_name
		"#{self.first_name} #{self.last_name}"
	end

	def self.import_from_json(data)
		ActiveRecord::Base.transaction do
			player = Player.find_or_create_by(first_name: data["first_name"],
											  last_name: data["last_name"],
				                              yahoo_player_id: data["yahoo_player_id"])
			player.update(headshot_url: data["headshot_url"],
				          uniform_number: data["uniform_number"],
				          positions: data["positions"])
			team_data = data["pro_team"]
			pro_team = ProTeam.find_or_create_by(name: team_data["name"],
				                                 abbreviation: team_data["abbreviation"],
				                                 yahoo_team_id: team_data["yahoo_team_id"])
			pro_player = player.pro_players.create(player_id: player.id,
												   pro_team_id: pro_team.id,
				                                   season: data["pro_player"]["season"])
			pro_player.player_stat = PlayerStat.create(games_played: data["stats"]["games_played"],
				goals: data["stats"]["goals"], assists: data["stats"]["assists"],
				points: data["stats"]["points"], plus_minus: data["stats"]["plus_minus"],
				penalty_minutes: data["stats"]["penalty_minutes"], powerplay_goals: data["stats"]["powerplay_goals"],
				powerplay_assists: data["stats"]["powerplay_assists"], powerplay_points: data["stats"]["powerplay_points"],
				shorthanded_goals: data["stats"]["shorthanded_goals"], shorthanded_assists: data["stats"]["shorthanded_assists"],
				shorthanded_points: data["stats"]["shorthanded_points"], game_winning_goals: data["stats"]["game_winning_goals"],
				shots_on_goal: data["stats"]["shots_on_goal"], shot_percentage:	data["stats"]["shot_percentage"],
				faceoffs_won: data["stats"]["faceoffs_won"], faceoffs_lost: data["stats"]["faceoffs_lost"],
				games_started: data["stats"]["games_started"], wins: data["stats"]["wins"],
				losses: data["stats"]["losses"], goals_against: data["stats"]["goals_against"],
				goals_against_average: data["stats"]["goals_against_average"], shots_against: data["stats"]["shots_against"],
				saves: data["stats"]["saves"], save_percentage: data["stats"]["save_percentage"],
				shutouts: data["stats"]["shutouts"], minutes_played: data["stats"]["minutes_played"],
				hits: data["stats"]["hits"], blocks: data["stats"]["blocks"]
									)
		end
	end
end
