class PoposController < ApplicationController
  def create
    Popo.import(params[:file])
    flash[:success] = "Popos uploaded"
    redirect_to root_url
  end
end
