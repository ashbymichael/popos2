@mapStyles = {
  minimalist: [
    {
      'featureType': 'administrative'
      'elementType': 'all'
      'stylers': [
        { 'visibility': 'on' }
        { 'saturation': '-21' }
        { 'lightness': '-37' }
        { 'gamma': '5.00' }
        { 'weight': '2.47' }
      ]
    }
    {
      'featureType': 'administrative'
      'elementType': 'labels.text.fill'
      'stylers': [ { 'color': '#444444' } ]
    }
    {
      'featureType': 'landscape'
      'elementType': 'all'
      'stylers': [
        { 'color': '#d8d8cf' }
        { 'visibility': 'on' }
      ]
    }
    {
      'featureType': 'landscape'
      'elementType': 'labels.text'
      'stylers': [ { 'visibility': 'on' } ]
    }
    {
      'featureType': 'landscape.man_made'
      'elementType': 'all'
      'stylers': [ { 'visibility': 'on' } ]
    }
    {
      'featureType': 'landscape.natural.landcover'
      'elementType': 'all'
      'stylers': [ { 'visibility': 'on' } ]
    }
    {
      'featureType': 'landscape.natural.landcover'
      'elementType': 'labels'
      'stylers': [ { 'visibility': 'on' } ]
    }
    {
      'featureType': 'landscape.natural.landcover'
      'elementType': 'labels.text'
      'stylers': [
        { 'saturation': '6' }
        { 'visibility': 'on' }
      ]
    }
    {
      'featureType': 'poi.business'
      'elementType': 'labels'
      'stylers': [ { 'visibility': 'off' } ]
    }
    {
      'featureType': 'poi.park'
      'elementType': 'all'
      'stylers': [ { 'visibility': 'off' } ]
    }
    {
      'featureType': 'road'
      'elementType': 'all'
      'stylers': [
        { 'saturation': -100 }
        { 'lightness': '23' }
        { 'visibility': 'on' }
        { 'hue': '#ff0000' }
        { 'gamma': '0.64' }
      ]
    }
    {
      'featureType': 'road'
      'elementType': 'labels.text'
      'stylers': [ { 'visibility': 'on' } ]
    }
    {
      'featureType': 'road.highway'
      'elementType': 'all'
      'stylers': [ { 'visibility': 'simplified' } ]
    }
    {
      'featureType': 'road.arterial'
      'elementType': 'labels.icon'
      'stylers': [ { 'visibility': 'off' } ]
    }
    {
      'featureType': 'water'
      'elementType': 'all'
      'stylers': [
        { 'color': '#494949' }
        { 'visibility': 'on' }
      ]
    }
  ]
  desaturated: [
    {
      featureType: 'all'
      stylers: [ { saturation: -50 } ]
    }
    {
      featureType: 'poi.business'
      elementType: 'labels'
      stylers: [ { visibility: 'off' } ]
    }
  ]
}
