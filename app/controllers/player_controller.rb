require 'uri'
require 'net/http'

class PlayerController < ApplicationController


	def jagr

		jagr = URI("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20fantasysports.players.stats%20where%20league_key%3D'352.l.641'%20and%20player_key%3D'352.p.35&format=json&diagnostics=true&callback=")

		@user = User.find(params[:user_id])
		Rails.logger.warn "The token is: #{@user.y_access_token}"
		request = Net::HTTP::Get.new(jagr)
		request["Authorization"] = "Bearer #{@user.y_access_token}"

		Rails.logger.warn "Request: #{request}"

		response = Net::HTTP.get(request)

		render json: { user: response.as_json }
	end
end