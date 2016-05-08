class PlayersController < ApplicationController
	before_action :authenticate!, except: [:index]

	### methods to front end

	def one
		@player = Player.find_by(yahoo_player_id: params["yahoo_player_id"])
		@pro_player = @player.pro_players.find_by(season: params["season"])
		@pro_team = @pro_player.pro_team
		@player_stat = @pro_player.player_stat
		if @player
			render "one.json.jbuilder", status: :ok
		else
			render json: "Player Not Found For This Season", status: :not_found
		end
	end

	def index
		@players = ProPlayer.includes(:player_stat, :pro_team)
	end

	def season
		# @players = Player.includes(:pro_players)
		@players = ProPlayer.includes(:player_stat, :pro_team).where(season: params[:season])
		render json: @players
	end

	### Straight to browser methods

	def bplayerpage
		@user = User.find(params[:user_id])
		@api = YahooApi.new(@user)
		response = @api.get_player_stats(params[:game_key], params[:player_key])
		render json: response
	end

	def bleague
		@user = User.find(params[:user_id])
		@api = YahooApi.new(@user)
		response = @api.get_league_players(params[:game_key], params[:league_key])
		render json: response.body
	end

	def bteam
		@user = User.find(params[:user_id])
		@api = YahooApi.new(@user)
		response = @api.get_team_players(params[:game_key], params[:league_key], params[:team_key])
		render json: response.body
	end

	def btransactions
		@user = User.find(params[:user_id])
		@api = YahooApi.new(@user)
		response = @api.get_transactions(params[:game_key], params[:league_key])
		render json: response.body
	end
end