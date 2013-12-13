class UserSessionsController < ApplicationController
  def new
    redirect_to LinkedIn::AuthorizationUrl.new.to_s
  end
end
