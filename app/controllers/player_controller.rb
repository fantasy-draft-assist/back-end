require 'uri'
require 'net/http'

class PlayerController < ApplicationController


	def one
		@user = User.find(params[:user_id])
		@api = YahooApi.new(@user)

		response = @api.get_player_stats(params[:game_key], params[:player_key])

		render json: { body: response.body }
	end
end