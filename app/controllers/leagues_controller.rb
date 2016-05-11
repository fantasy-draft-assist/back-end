class LeaguesController < ApplicationController
	before_action :authenticate!

	def update
		@league = League.find_by(user_id: current_user.id)
		@league.update(team_count: params["team_count"],
      							player_count: params["player_count"],
      							goalie_count: params["goalie_count"],
      							games_played: params["games_played"],
      							goals: params["goals"],
      							assists: params["assists"],
      							points: params["points"],
      							plus_minus: params["plus_minus"],
      							penalty_minutes: params["penalty_minutes"],
      							powerplay_goals: params["powerplay_goals"],
      							powerplay_assists: params["powerplay_assists"],
      							powerplay_points: params["powerplay_points"],
      							shorthanded_goals: params["shorthanded_goals"],
      							shorthanded_assists: params["shorthanded_assists"],
      							shorthanded_points: params["shorthanded_points"],
      							game_winning_goals: params["game_winning_goals"],
      							shots_on_goal: params["shots_on_goal"],
      							shot_percentage: params["shot_percentage"],
      							faceoffs_won: params["faceoffs_won"],
      							faceoffs_lost: params["faceoffs_lost"],
      							games_started: params["games_started"],
      							wins: params["wins"],
      							losses: params["losses"],
      							goals_against: params["goals_against"],
      							goals_against_average: params["goals_against_average"],
      							shots_against: params["shots_against"],
      							saves: params["saves"],
      							save_percentage: params["save_percentage"],
      							shutouts: params["shutouts"],
      							minutes_played: params["minutes_played"],
      							hits: params["hits"],
      							blocks: params["blocks"])

		render json: @league
	end

      def show
            @league = League.find_by(user_id: current_user.id)

            render json: @league.as_json(except: [:created_at, :updated_at, :user_id])
      end

end
