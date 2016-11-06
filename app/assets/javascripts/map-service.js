let mapService = {
  mapDiv: $('#map-view'),
  markers: [],
  userLat: undefined,
  userLng: undefined,
  infoWindow: undefined,

  initMap() {
    mapService.mapDiv = new google.maps.Map(document.getElementById('map-view'), {
      center: {
        lat: 37.7880,
        lng: -122.405
      },
      scrollwheel: false,
      zoom: 15,
      styles: mapStyles.minimalist
    }
    );
  },

  checkIfSF() {
    if (mapService.userLat > 37.77478541 && mapService.userLat < 37.82144645 && mapService.userLng > -122.52399445 && mapService.userLng < -122.3588562) {
      return true;
    } else {
      return false;
    }
  },

  getNearby() {
    let data = {
      'userLat': mapService.userLat,
      'userLng': mapService.userLng};
    let req = $.ajax({
      url: '/popos/nearby',
      method: 'post',
      data,
      dataType: 'json'});
    req.done(function(res) {
      $('#list-view').html(res.html);
      mapService.hideAllMarkers();
      mapService.markNearbyOnMap(res);
      mapService.mapDiv.panTo(mapService.markers[0].getPosition());
      mapService.mapDiv.setZoom(17);
    });
  },

  getUserLocation() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(mapService.setUserLocation, mapService.getUserLocationError);
    } else {
      currentLocation.innerHTML = 'Geolocation is not supported by this browser.';
    }
  },

  setUserLocation(pos) {
    let crd = pos.coords;
    mapService.userLat = crd.latitude;
    mapService.userLng = crd.longitude;
  },

  getUserLocationError(err) {
    console.warn(`ERROR(${err.code}): ${err.message}`);
  },

  addPopoMarkersToMap() {
    let req = $.ajax({
      url: '/markers',
      dataType: 'json'});
    req.done(function(popos) {
      infoWindow = new google.maps.InfoWindow;
      let i = 0;
      while (i < popos.length) {
        mapService.placeMarker(popos[i]);
        i += 1;
      }
    });
    req.fail(function() {
      console.warn('Failed to locate POPOS');
    });
  },

  markNearbyOnMap(popos) {
    let i = 0;
    return (() => {
      let result = [];
      while (i < 5) {
        mapService.placeMarker(popos[i]);
        result.push(i += 1);
      }
      return result;
    })();
  },

  hideAllMarkers() {
    let i = 0;
    while (i < mapService.markers.length) {
      mapService.markers[i].setMap(null);
      i += 1;
    }
    mapService.markers.length = 0;
  },

  placeMarker(popo) {
    let userLatLng = new google.maps.LatLng(mapService.userLat, mapService.userLng);
    let popoLatLng = new google.maps.LatLng(popo.lat, popo.lng);
    let marker = new google.maps.Marker({
      position: popoLatLng,
      map: mapService.mapDiv,
      title: popo.name});
    mapService.markers.push(marker);
    (function(marker, popo) {
      let source = $('#info-window-template').html();
      let template = Handlebars.compile(source);
      let context = popo;
      let html = template(context);
      google.maps.event.addListener(marker, 'click', function(e) {
        infoWindow.setContent(html);
        infoWindow.open(mapService.mapDiv, marker);
      });
    })(marker, popo);
  }
};
