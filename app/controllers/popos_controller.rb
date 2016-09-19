class PoposController < ApplicationController
  def index
    @popos = Popo.all.page(params[:page])
  end

  def create
    Popo.import(params[:file])
    flash[:success] = "Popos uploaded"
    redirect_to root_url
  end
end
