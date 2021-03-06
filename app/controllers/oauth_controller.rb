class OauthController < ApplicationController

	def new
		@user = User.find(params[:user_id])
		@api = YahooApi.new(@user)
		Rails.logger.warn "request url:#{@api.oauth_request_url}"
		redirect_to @api.oauth_request_url
	end

	def create
		code = params[:code]
		@user = User.find(params[:user_id])
		@api = YahooApi.new(@user)
		@api.oauth_get_token(code)
		render json: { user: @user.as_json(only: [:y_access_token, :y_refresh_token, :y_token_type, :y_expires_at]) },
		  status: :ok
	end
end
