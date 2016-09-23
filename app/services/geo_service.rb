class GeoService
  def self.grab_location
    res = HTTParty.post("https://www.googleapis.com/geolocation/v1/geolocate?key=#{ENV['GOOGLE_KEY']}")
    return {
      lat:  res['location']['lat'],
      long: res['location']['lng']
    }
  end

  def self.get_distance(args)
    r = 6371e3 # meters
    ph1 = args[:origin][:lat] * Math::PI / 180  #convert to radians
    ph2 = args[:destination][:lat] * Math::PI / 180
    dph = (args[:destination][:lat] - args[:origin][:lat]) * Math::PI / 180
    dl = (args[:destination][:lng] - args[:origin][:lng]) * Math::PI / 180
    a = Math.sin(dph / 2) * Math.sin(dph / 2) + Math.cos(ph1) *
        Math.cos(ph2) * Math.sin(dl / 2) * Math.sin(dl / 2)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
    r * c
  end

  def self.find_nearest(args)
    result = {}

    Popo.all.each do |popo|
      result[popo.id] = GeoService.get_distance(
        origin: {lat: args[:user_lat].to_f, lng: args[:userLng].to_f},
        destination: {lat: popo.lat, lng: popo.lng})
    end

    result = result.sort_by { |k,v| v }[0..4]
    result.map! { |popo| Popo.find(popo[0]) }
  end
end
