require 'uri'
require 'net/http'

class PlayerController < ApplicationController


	def one(player_key)
		@user = User.find(params[:user_id])
		@api = YahooApi.new(@user)

		response = @api.get_player_stats(params[:player_key])

		render json: { body: @api.response.body }
	end
end