class UsersController < ApplicationController
	before_action :authenticate!, only: [:check_auth]

	def check_auth
		if current_user
			render json: { message: "CURRENT USER: #{current_user.email}."},
				status: :ok
		else
			render json: { message: "AUTHORIZATION IS DOWN."},
				status: :unauthorized
		end
	end

	# possible other user methods
end
