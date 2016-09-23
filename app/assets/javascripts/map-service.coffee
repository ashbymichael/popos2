@mapService = {
  mapDiv: $('#map-view')
  markers: []
  userLat: undefined
  userLng: undefined

  initMap: ->
    mapService.mapDiv = new google.maps.Map(document.getElementById('map-view'),
      center:
        lat: 37.7880
        lng: -122.405
      scrollwheel: false
      zoom: 15
      styles: mapStyles.minimalist)
    return

  checkIfSF: ->
    if mapService.userLat > 37.77478541 and mapService.userLat < 37.82144645 and mapService.userLng > -122.52399445 and mapService.userLng < -122.3588562
      return true
    else
      return false

  getNearby: ->
    data = {
      'userLat': mapService.userLat
      'userLng': mapService.userLng}
    req = $.ajax(
      url: '/popos/nearby'
      method: 'post'
      data: data
      dataType: 'json')
    req.done (res) ->
      $('#list-view').html(res.html)
      mapService.hideAllMarkers()
      mapService.markNearbyOnMap(res)
      mapService.mapDiv.panTo(mapService.markers[0].getPosition())
      mapService.mapDiv.setZoom(17)
      return
    return

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
    return

  getUserLocationError: (err) ->
    console.warn 'ERROR(' + err.code + '): ' + err.message
    return

  addPopoMarkersToMap: ->
    req = $.ajax(
      url: '/markers'
      dataType: 'json')
    req.done (popos) ->
      infoWindow = new google.maps.InfoWindow
      i = 0
      while i < popos.length
        mapService.placeMarker(popos[i])
        i += 1
      return
    req.fail ->
      console.warn 'Failed to locate POPOS'
      return
    return

  markNearbyOnMap: (popos) ->
    i = 0
    while i < 5
      mapService.placeMarker(popos[i])
      i += 1

  hideAllMarkers: ->
    i = 0
    while i < mapService.markers.length
      mapService.markers[i].setMap(null)
      i += 1
    mapService.markers.length = 0
    return

  placeMarker: (popo) ->
    userLatLng = new google.maps.LatLng(mapService.userLat, mapService.userLng)
    popoLatLng = new google.maps.LatLng(popo.lat, popo.lng)
    marker = new google.maps.Marker(
      position: popoLatLng
      map: mapService.mapDiv
      title: popo.name)
    mapService.markers.push(marker)
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
    return
}
