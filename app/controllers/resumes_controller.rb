class ResumesController < ApplicationController
  def show
    render json: {"expires_in" => 5184000, "access_token" => "AQXdSP_W41_UPs5ioT_t8HESyODB4FqbkJ8LrV_5mff4gPODzOYR"}
  end

  private

  def resume_params
    params.permit(:state, :code)
  end
end
