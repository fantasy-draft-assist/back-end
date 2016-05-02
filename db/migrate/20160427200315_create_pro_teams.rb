class CreateProTeams < ActiveRecord::Migration
  def change
    create_table :pro_teams do |t|
    	t.string	:name
        t.string    :abbreviation
        t.integer   :yahoo_team_id
        t.text      :logo_url
        t.timestamps null: false
    end
  end
end
