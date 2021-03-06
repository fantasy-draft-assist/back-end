class InitializeDefaultsForLeagueSettings < ActiveRecord::Migration
	def change
  		change_column_default(:leagues, :games_played, false)
    	change_column_default(:leagues, :goals, false)
    	change_column_default(:leagues, :assists, false)
    	change_column_default(:leagues, :points, false)
    	change_column_default(:leagues, :plus_minus, false)
    	change_column_default(:leagues, :penalty_minutes, false)
    	change_column_default(:leagues, :powerplay_goals, false)
    	change_column_default(:leagues, :powerplay_assists, false)
    	change_column_default(:leagues, :powerplay_points, false)
    	change_column_default(:leagues, :shorthanded_goals, false)
    	change_column_default(:leagues, :shorthanded_assists, false)
    	change_column_default(:leagues, :shorthanded_points, false)
    	change_column_default(:leagues, :game_winning_goals, false)
    	change_column_default(:leagues, :shots_on_goal, false)
    	change_column_default(:leagues, :shot_percentage, false)
    	change_column_default(:leagues, :faceoffs_won, false)
    	change_column_default(:leagues, :faceoffs_lost, false)
    	change_column_default(:leagues, :games_started, false)
    	change_column_default(:leagues, :wins, false)
    	change_column_default(:leagues, :losses, false)
    	change_column_default(:leagues, :goals_against, false)
    	change_column_default(:leagues, :goals_against_average, false)
    	change_column_default(:leagues, :shots_against, false)
    	change_column_default(:leagues, :saves, false)
    	change_column_default(:leagues, :save_percentage, false)
    	change_column_default(:leagues, :shutouts, false)
    	change_column_default(:leagues, :minutes_played, false)
    	change_column_default(:leagues, :hits, false)
    	change_column_default(:leagues, :blocks, false)
    end
end
