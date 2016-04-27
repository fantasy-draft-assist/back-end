class OauthController < ApplicationController

	def new
		@user = User.find(params[:user_id])
		@api = YahooApi.new(@user)
		redirect_to @api.oauth_request_url
	end

	def create
		code = params[:code]
		@user = User.find(params[:user_id])
		@api = YahooApi.new(@user)
		@api.oauth_get_token(code)
		render json: { user: @user.as_json(only: [:y_access_token, :y_refresh_token]) },
		  status: :ok
	end
end
