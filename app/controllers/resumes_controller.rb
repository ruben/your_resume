class ResumesController < ApplicationController
  def show
    access_token = LinkedIn::RequestAccessToken.fetch(resume_params[:code])
    render json: access_token
  end

  private

  def resume_params
    params.permit(:state, :code)
  end
end
