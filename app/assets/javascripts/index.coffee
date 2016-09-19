$(document).on 'turbolinks:load', ->
  mapDiv = $('#map-view')
  listDiv = $('#list-view')

  switchViews = ->
    current = $('#view-switcher-button').text()
    if current == 'view as list'
      $('#view-switcher-button').text 'view as map'
    else
      $('#view-switcher-button').text 'view as list'
    mapDiv.toggle()
    listDiv.toggle()
    return

  $('#view-switcher-button').click(switchViews)

  return
