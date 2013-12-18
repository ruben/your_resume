class LinkedinAuthorizationController < ApplicationController
  def authorize
    redirect_to oauth_authorize_url
  end

  def callback
    if @code = params[:code]
      @authorization_info = oauth_authorize params[:code]
      @user = User.from_authorization_info @authorization_info
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    else
      redirect_to linkedin_new_session_path
    end

  end

  def oauth_authorize_url
    LinkedIn::OauthClient.authorize_url
  end

  def oauth_authorize code
    LinkedIn::OauthClient.authorize params[:code]
  end
end
