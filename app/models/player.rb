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
			pro_player.player_stat = PlayerStat.create(data["stats"])
		end
	end
end
