require 'uri'
require 'net/http'

class PlayerController < ApplicationController


	def jagr
		@user = User.find(params[:user_id])

		url = URI("https://fantasysports.yahooapis.com/fantasy/v2/player/352.p.35/stats?format=json")
		# url = URI("https://fantasysports.yahooapis.com/fantasy/v2/players;player_keys=352.p.35?format=json")
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