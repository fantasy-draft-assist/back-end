class CreatePlayerStats < ActiveRecord::Migration
  def change
    create_table :player_stats do |t|
    	t.integer   :pro_player_id
    	t.integer	:games_played
    	t.integer	:goals
    	t.integer	:assists
    	t.integer	:points
    	t.integer	:plus_minus
    	t.integer	:penalty_minutes
    	t.integer	:powerplay_goals
    	t.integer	:powerplay_assists
    	t.integer	:powerplay_points
    	t.integer	:shorthanded_goals
    	t.integer	:shorthanded_assists
    	t.integer	:shorthanded_points
    	t.integer	:game_winning_goals
    	t.integer	:game_tying_goals
    	t.integer	:shots_on_goal
    	t.float		:shot_percentage
    	t.integer	:faceoffs_won
    	t.integer	:faceoffs_lost
    	t.integer	:games_started
    	t.integer	:wins
    	t.integer	:losses
    	t.integer	:goals_against
    	t.float		:goals_against_average
    	t.integer	:shots_against
    	t.integer	:saves
    	t.float		:save_percentage
    	t.integer	:shutouts
    	t.integer	:minutes_played
    	t.integer	:hits
    	t.integer	:blocks

      t.timestamps null: false
    end
  end
end
