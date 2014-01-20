class LinkedinAuthorizationController < ApplicationController
  def authorize
    redirect_to oauth_authorize_url
  end

  def callback
    if @code = params[:code]
      @user = User.from_authorization_info linked_in_client
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    else
      redirect_to new_user_session_path
    end

  end

  def oauth_authorize_url
    LinkedIn::OauthClient.authorize_url
  end

  def linked_in_client
    LinkedIn::Client.new oauth_authorize(params[:code])[:access_token]
  end

  def oauth_authorize code
    LinkedIn::OauthClient.authorizeparams[:code]
  end
end
