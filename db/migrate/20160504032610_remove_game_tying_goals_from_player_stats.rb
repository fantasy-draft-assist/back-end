class RemoveGameTyingGoalsFromPlayerStats < ActiveRecord::Migration
  def change
  	remove_column :player_stats, :game_tying_goals
  end
end
