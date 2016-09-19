$(document).on 'turbolinks:load', ->
  mapDiv  = $('#map-view')
  listDiv = $('#list-view')
  loading = $("#loading")
  userLat = undefined
  userLng = undefined

  switchViews = ->
    current = $('#view-switcher-button').text()
    if current == 'view as list'
      $('#view-switcher-button').text 'view as map'
    else
      $('#view-switcher-button').text 'view as list'
    mapDiv.toggle()
    listDiv.toggle()
    return

  viewPage = (e) ->
    e.preventDefault()
    console.log('getting next page')
    $.ajax(url: $(this).attr('href')).done (res) ->
      $('#list-view').html($($.parseHTML(res)).filter('#list-view').html())
      console.log($($.parseHTML(res)).filter('#list-view'))
      return
    return

  getUserLocation = ->
    console.log('getting location')
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition setUserLocation, getUserLocationError
    else
      currentLocation.innerHTML = 'Geolocation is not supported by this browser.'
    return

  setUserLocation = (pos) ->
    crd = pos.coords
    userLat = crd.latitude
    userLng = crd.longitude
    return

  getUserLocationError = (err) ->
    console.warn 'ERROR(' + err.code + '): ' + err.message
    return

  # loading.hide()
  # $(document).ajaxStart(->
  #   loading.show()
  #   return
  # ).ajaxStop ->
  #   loading.hide()
  #   return

  $('#view-switcher-button').click(switchViews)
  $(document.body).on('click', '.pagination a', viewPage)

  return
