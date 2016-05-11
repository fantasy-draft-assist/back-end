class SearchController < ApplicationController
	def player_search
    @players = Player.includes(:pro_players, :pro_teams)
    @players = @players.search_by_name(params[:name]) if params[:name].present?

    render "player_search.json.jbuilder"
  end
end