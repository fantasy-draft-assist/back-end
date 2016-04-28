class RegistrationsController < ApplicationController
	skip_before_filter :verify_authentictiy_token, only: [:create, :login]

	def create
		@user = User.new(username: params["username"],
						email: params["email"],
						password: params["password"],
						favorite_team: params["favorite_team"])
		@user.ensure_auth_token
		if @user.save
			render json: { user: @user.as_json(only:
								[:username, :email, :auth_token] )},
				status: :created
		else
			render json: { errors: @user.errors.full_messages },
				status: :unprocessable_entity
		end
	end

	def login
		@user = User.find_by!(username: params["username"])
		if @user.authenticate(params["password"])
			render json: { user: @user.as_json(only: [:username, :id, :auth_token. :favorite_team]) },
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