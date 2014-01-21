class LinkedinAuthorizationController < ApplicationController
  def authorize
    redirect_to oauth_authorize_url
  end

  def callback
    if @code = params[:code]
      @user = User.from_linked_in linked_in_client
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    else
      redirect_to new_user_session_path
    end

  end

  def oauth_authorize_url
    LinkedIn::OauthClient.authorize_url
  end

  #TODO move to LinkedIn::Client?
  def linked_in_client
    authorization_info = LinkedIn::OauthClient.authorize params[:code]
    LinkedIn::Client.new(authorization_info["access_token"], authorization_info["expires_in"])
  end
end
