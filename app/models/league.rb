class League < ActiveRecord::Base
	belongs_to :user
	has_many :fantasy_teams

	validates :name, presence: true, uniqueness: true
end
