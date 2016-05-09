class RegistrationsController < ApplicationController
	skip_before_filter :verify_authentictiy_token, only: [:create, :login]

	def create
		@user = User.new(username: params["username"],
						email: params["email"],
						password: params["password"],
						favorite_team: params["favorite_team"])
		@user.ensure_auth_token
		if @user.save
			@league = League.create(name: params["league_name"], team_count: params["team_count"],
							player_count: params["player_count"], goalie_count: params["goalie_count"],
							user_id: @user.id)
			binding.pry
			render json: { 	user: @user.as_json(only:
							[:username, :email, :auth_token, :favorite_team] ),
							league: @league.as_json(only: 
							[:id, :name, :team_count, :player_count, :goalie_count])
						 }, status: :created
		else
			render json: {
				errors: @user.errors.full_messages,
				league_errors: @league.errors.full_messages
			    },
				status: :unprocessable_entity
		end
	end

	def login
		@user = User.find_by!(username: params["username"])
		@league = League.find_by(user_id: @user.id)
		if @user.authenticate(params["password"])
			render json: { user: @user.as_json(only: [:username, :id, :auth_token, :favorite_team]),
							league: @league.as_json(only: [:name]) },
				status: :ok
		else
			render json: { message: "Invalid Email Or Password."},
				status: :unauthorized
		end
	end

	def destroy	
		@user = User.find_by(username: params["username"])
		if @user.authenticate(params["password"])
			@user.destroy
				render json: "User Destroyed.",
				status: :accepted
		else
			render json: { error: "Unauthorized" },
				status: :unauthorized
		end
	end
end