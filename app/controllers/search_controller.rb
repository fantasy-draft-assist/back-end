class SearchController < ApplicationController
	def player_search
    @players = Player.all
    @players = @players.fname(params[:first_name]) if params[:first_name].present?
    @players = @players.lname(params[:last_mame]) if params[:last_name].present?
    render json: @players
  end
end