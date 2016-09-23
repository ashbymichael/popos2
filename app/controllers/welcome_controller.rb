class WelcomeController < ApplicationController
  def index
    @popos = Popo.all.page(params[:page])
  end
end
