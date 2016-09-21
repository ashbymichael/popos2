# mapDiv  = $('#map-view')
#
# initMap = ->
#   mapService.mapDiv = new google.maps.Map(document.getElementById('map-view'),
#     center:
#       lat: 37.7880
#       lng: -122.405
#     scrollwheel: false
#     zoom: 15
#     styles: [
#       {
#         featureType: 'all'
#         stylers: [ { saturation: -50 } ]
#       }
#       {
#         featureType: 'poi.business'
#         elementType: 'labels'
#         stylers: [ { visibility: 'off' } ]
#       }
#     ])
#   return

@mapService = {
  mapDiv: $('#map-view')
  userLat: undefined
  userLng: undefined

  initMap: ->
    mapService.mapDiv = new google.maps.Map(document.getElementById('map-view'),
      center:
        lat: 37.7880
        lng: -122.405
      scrollwheel: false
      zoom: 15
      styles: [
        {
          featureType: 'all'
          stylers: [ { saturation: -50 } ]
        }
        {
          featureType: 'poi.business'
          elementType: 'labels'
          stylers: [ { visibility: 'off' } ]
        }
      ])
    return

  checkIfSF: ->
    if mapService.userLat > 37.77478541 and mapService.userLat < 37.82144645 and mapService.userLng > -122.52399445 and mapService.userLng < -122.3588562
      return true
    else
      return false

  getUserLocation: ->
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition mapService.setUserLocation, mapService.getUserLocationError
    else
      currentLocation.innerHTML = 'Geolocation is not supported by this browser.'
    return

  setUserLocation: (pos) ->
    crd = pos.coords
    mapService.userLat = crd.latitude
    mapService.userLng = crd.longitude
    console.log('your location: ' + mapService.userLat + ', ' + mapService.userLng)
    console.log('In San Francisco? ' + mapService.checkIfSF())
    return


  getUserLocationError: (err) ->
    console.warn 'ERROR(' + err.code + '): ' + err.message
    return

  addPopoMarkersToMap: ->
    req = $.ajax(
      url: '/markers'
      dataType: 'json')
    req.done (popos) ->
      infoWindow = new (google.maps.InfoWindow)
      i = 0
      while i < popos.length
        popo = popos[i]
        userLatLng = new (google.maps.LatLng)(mapService.userLat, mapService.userLng)
        popoLatLng = new (google.maps.LatLng)(popo.lat, popo.lng)
        marker = new (google.maps.Marker)(
          position: popoLatLng
          map: mapService.mapDiv
          title: popo.name)
        # distance = google.maps.geometry.spherical.computeDistanceBetween(userLatLng, popoLatLng)
        do (marker, popo) ->
          source = $('#info-window-template').html()
          template = Handlebars.compile(source)
          context = popo
          html = template(context)
          google.maps.event.addListener marker, 'click', (e) ->
            infoWindow.setContent html
            infoWindow.open mapService.mapDiv, marker
            return
          return
        i += 1
      return
    req.fail ->
      console.warn 'Failed to locate POPOS'
      return
    return

}
