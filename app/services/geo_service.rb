class GeoService
  def self.grab_location
    res = HTTParty.post("https://www.googleapis.com/geolocation/v1/geolocate?key=#{ENV['GOOGLE_KEY']}")
    return {
      lat:  res['location']['lat'],
      long: res['location']['lng']
    }
  end

  # def self.get_distance(args)
    # origin = args[:origin]
    # destination = args[:destination]
    # res = HTTParty.post("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{origin[:lat]},#{origin[:long]}&destinations=#{destination[:lat]},#{destination[:long]}&key=#{ENV['GOOGLE_KEY']}")
    # res['rows'][0]['elements'][0]['distance']['text'][0..-4].to_f
  # end

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
end
