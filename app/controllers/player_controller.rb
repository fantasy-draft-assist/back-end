require 'uri'
require 'net/http'

class PlayerController < ApplicationController


	def jagr

		url = URI("https://query.yahooapis.com/v1/yql?q=select%20*%20from%20fantasysports.players.stats%20where%20league_key%3D'352.l.641'%20and%20player_key%3D'352.p.35'&format=json&diagnostics=true&callback=")

		@user = User.find(params[:user_id])
		Rails.logger.warn "The token is: #{@user.y_access_token}"

		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		request = Net::HTTP::Get.new(url)
		request["Authorization"] = "#{@user.y_access_token}"
		response = http.request(request)

		Rails.logger.warn "Request: #{request}"

		render json: { user: response.body }
	end
end