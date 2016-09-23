class PoposController < ApplicationController
  def index
    @popos = Popo.order(:id).page(params[:page])

    if request.xhr?
      render erb: :index, layout: false
    end
  end

  def create
    Popo.import(params[:file])
    redirect_to root_url
  end

  def show
    @popo = Popo.find(params[:id])
  end

  def nearby
    result = {}

    @nearby_popos = GeoService.find_nearest(user_lat: params['userLat'],
                                            user_lng: params['userLng'])

    @nearby_popos.each_with_index { |popo, i| result[i] = popo.attributes }
    result['html'] = render_to_string(:nearby, layout: false)

    render json: result
  end

  def map_markers
    @popos = Popo.all
    render json: @popos
  end
end
