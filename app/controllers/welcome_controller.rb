class WelcomeController < ApplicationController
  def index
    GeoService.say_hello
    @popos = Popo.all.page(params[:page])
  end
end
