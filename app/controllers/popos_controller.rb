class PoposController < ApplicationController
  def index
    @popos = Popo.order(:id).page(params[:page])

    if request.xhr?
      render erb: :index, layout: false
    end
  end

  def create
    Popo.import(params[:file])
    flash[:success] = "Popos uploaded"
    redirect_to root_url
  end

  def map_markers
    @popos = Popo.all
    respond_to do |format|
        format.html { redirect_to @popos, notice: 'User was successfully created.' }
        format.js   {}
        format.json { render json: @popos }
    end
  end
end
