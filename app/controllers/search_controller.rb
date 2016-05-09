class SearchController < ApplicationController
	def player_search
    @players = Player.includes(:pro_players)
    @players = @players.fname(params[:first_name]) if params[:first_name].present?
    @players = @players.lname(params[:last_name]) if params[:last_name].present?
    binding.pry
    render json: @players
  end
end