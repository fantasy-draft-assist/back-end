require 'uri'
require 'net/http'

class PlayerController < ApplicationController


	def jagr

		url = URI("http://fantasysports.yahooapis.com/fantasy/v2/players;player_keys=352.p.35")

		@user = User.find(params[:user_id])
		Rails.logger.warn "The token is: #{@user.y_access_token}"

		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		request = Net::HTTP::Get.new(url)
		request["Authorization"] = "#{@user.y_access_token}"
		response = http.request(request)

		Rails.logger.warn "Request: #{request}"

		render json: { headers: response, body: response.body }
	end
end