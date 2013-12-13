class LinkedinAuthenticationController < ApplicationController
  def callback
    @user_info = LinkedIn::OauthClient.authorize params[:code]
  end
end
