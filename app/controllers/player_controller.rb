require 'uri'
require 'net/http'

class PlayerController < ApplicationController


	def jagr

		url = URI("https://fantasysports.yahooapis.com/fantasy/v2?q=select%20*%20from%20fantasysports.players.stats%20where%20league_key%3D'352.l.641'%20and%20player_key%3D'352.p.35'&format=json&diagnostics=true&callback=")

		@user = User.find(params[:user_id])

		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		request = Net::HTTP::Get.new(url)
		request["Authorization"] = "#{@user.y_access_token}"
		request["cache-control"] = 'no-cache'
	  	request["content-type"] = 'application/x-www-form-urlencoded'
		response = http.request(request)

		render json: { headers: response, body: response.body }
	end
end