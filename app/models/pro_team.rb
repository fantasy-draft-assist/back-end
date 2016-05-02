class ProTeam < ActiveRecord::Base
  has_many :pro_players
  has_many :players, through: :pro_players
end