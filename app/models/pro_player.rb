class ProPlayer < ActiveRecord::Base
	belongs_to :pro_team
	belongs_to :player

	has_many :player_stats
end
