class FantasyPlayer < ActiveRecord::Base
	has_one :player

	belongs_to :fantasy_team
end
