class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
    	t.string	:name
    	t.integer	:team_count
    	t.integer	:player_count
    	t.integer	:goalie_count
    	t.boolean	:games_played
    	t.boolean	:goals
    	t.boolean	:assists
    	t.boolean	:points
    	t.boolean	:plus_minus
    	t.boolean	:penalty_minutes
    	t.boolean	:powerplay_goals
    	t.boolean	:powerplay_assists
    	t.boolean	:powerplay_points
    	t.boolean	:shorthanded_goals
    	t.boolean	:shorthanded_assists
    	t.boolean	:shorthanded_points
    	t.boolean	:game_winning_goals
    	t.boolean	:shots_on_goal
    	t.boolean	:shot_percentage
    	t.boolean	:faceoffs_won
    	t.boolean	:faceoffs_lost
    	t.boolean	:games_started
    	t.boolean	:wins
    	t.boolean	:losses
    	t.boolean	:goals_against
    	t.boolean	:goals_against_average
    	t.boolean	:shots_against
    	t.boolean	:saves
    	t.boolean	:save_percentage
    	t.boolean	:shutouts
    	t.boolean	:minutes_played
    	t.boolean	:hits
    	t.boolean	:blocks

      t.timestamps null: false
    end
  end
end
