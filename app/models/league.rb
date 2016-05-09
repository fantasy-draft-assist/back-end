class League < ActiveRecord::Base
	belongs_to :user
	has_many :fantasy_teams

	validates :name, presence: true
	validates :user_id, presence: true
end
