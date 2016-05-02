class ProPlayer < ActiveRecord::Base
	belongs_to :pro_team
	belongs_to :player
end
