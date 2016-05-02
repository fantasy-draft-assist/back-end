class CreateProPlayers < ActiveRecord::Migration
  def change
    create_table :pro_players do |t|
      t.integer :player_id
      t.integer :pro_team_id
      t.integer :season

      t.timestamps null: false
    end
  end
end
