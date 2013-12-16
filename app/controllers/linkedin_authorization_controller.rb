class LinkedinAuthorizationController < ApplicationController
  def authorize
      redirect_to LinkedIn::OauthClient.authorize_url
  end

  def callback
    @authorization_info = LinkedIn::OauthClient.authorize params[:code]
  end
end
