json.array! @pro_players do |pro_player|
  json.player pro_player.player
  json.player_stats pro_player.player_stat
end
