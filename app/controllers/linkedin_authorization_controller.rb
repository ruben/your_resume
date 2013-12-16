class LinkedinAuthorizationController < ApplicationController
  def authorize
      redirect_to LinkedIn::OauthClient.authorize_url
  end

  def callback
    @authorization_info = LinkedIn::OauthClient.authorize params[:code]
    render text: @authorization_info
  end
end
