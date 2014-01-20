class ResumesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user_profile = current_user.profile
  end

  def refresh
    current_user.profile.load_from LinkedIn::Client.new(current_user.access_token)
    redirect_to resumes_show_path
  end
end
