class PlayersController < ApplicationController
	before_action :authenticate!

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

	def one_all_seasons
		@player = Player.find_by(yahoo_player_id: params["yahoo_player_id"])
		@pro_players = @player.pro_players.all
		@pro_team = @pro_players.first.pro_team
		@player_stats = @pro_players.map { |e| e.player_stat  }
		if @player
			render "oneseason.json.jbuilder", status: :ok
		else
			render json: "Player Not Found.", status: :not_found
		end
	end

	def index
		@players = Player.joins(:player_stats).where("pro_players.season = #{params[:season]} AND player_stats.#{params[:stat_name]} IS NOT NULL").order("player_stats.#{params[:stat_name]} DESC").page(1).per(25)

		if @players
			render json: @players.all.to_json(:include => :player_stats)
		else
			render json: "Something is wrong.", status: :not_found
		end
	end

	def season
		@players = Player.includes(:pro_players)
		@pro_players = ProPlayer.where(season: params["season"]).includes(:player_stat)
		@season = Kaminari.paginate_array(@pro_players).page(params["page"]).per(25)
		render json: @season
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