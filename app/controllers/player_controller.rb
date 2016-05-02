require 'uri'
require 'net/http'

class PlayerController < ApplicationController


	def one
		@user = User.find(params[:user_id])
		@api = YahooApi.new(@user)
		response = @api.get_player_stats(params[:game_key], params[:player_key])
		render json: response.body
	end

	def league
		@user = User.find(params[:user_id])
		@api = YahooApi.new(@user)
		response = @api.get_league_players(params[:game_key], params[:league_key])
		render json: { body: response.body }
	end

	def team
		@user = User.find(params[:user_id])
		@api = YahooApi.new(@user)
		response = @api.get_team_players(params[:game_key], params[:league_key], params[:team_key])
		render json: { body: response.body }
	end

	def transactions
		@user = User.find(params[:user_id])
		@api = YahooApi.new(@user)
		response = @api.get_transactions(params[:game_key], params[:league_key])
		render json: { body: response.body }
	end
end