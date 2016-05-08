class CreateFantasyPlayers < ActiveRecord::Migration
  def change
    create_table :fantasy_players do |t|
    	t.integer	:fantasy_team_id
    	t.string	:position

      t.timestamps null: false
    end
  end
end
