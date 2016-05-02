class Player < ActiveRecord::Base
	has_many :stats
	has_many :pro_players
	has_many :pro_teams, through: :pro_players

	def full_name
		"#{self.first_name} #{self.last_name}"
	end
end
