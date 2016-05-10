json.array! @pro_players do |pro_player|
  json.player pro_player.player
  json.pro_team pro_player.pro_team
  json.player_stats pro_player.player_stat
end
