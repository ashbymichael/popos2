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

  def show
    @popo = Popo.find(params[:id])
  end

  def nearby
    @nearby_popos, result = {}, {}

    Popo.all.each do |popo|
      @nearby_popos[popo.id] = GeoService.get_distance(
        origin: {lat: params['userLat'].to_f, lng: params['userLng'].to_f}, destination: {lat: popo.lat, lng: popo.lng}
      )
    end

    @nearby_popos = @nearby_popos.sort_by { |k,v| v }[0..4]
    @nearby_popos.map! { |popo| Popo.find(popo[0]) }
    @nearby_popos.each_with_index { |popo, i| result[i] = popo.attributes }
    result['html'] = render_to_string(:nearby, layout: false)
    # @nearby_popos = @nearby_popos.to_json
    render json: result
  end

  def map_markers
    @popos = Popo.all
    render json: @popos
    # respond_to do |format|
    #     format.html { redirect_to @popos, notice: 'POPOS was successfully created.' }
    #     format.js   {}
    #     format.json { render json: @popos }
    # end
  end
end
