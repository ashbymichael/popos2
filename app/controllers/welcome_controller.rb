class WelcomeController < ApplicationController
  def index
    p GeoService.grab_location
    @popos = Popo.all.page(params[:page])
  end
end
