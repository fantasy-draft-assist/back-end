class FantasyTeam < ActiveRecord::Base
	has_many :fantasy_players
	has_many :players, through: :fantasy_players
	
	belongs_to :league
	belongs_to :user
end

