json.array! @players do |player|
	json.player player
	json.pro_team player.pro_teams.first
end