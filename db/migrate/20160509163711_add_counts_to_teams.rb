class AddCountsToTeams < ActiveRecord::Migration
  def change
  	add_column :fantasy_teams, :player_count, :integer
  	add_column :fantasy_teams,	:goalie_count, :integer
  end
end
