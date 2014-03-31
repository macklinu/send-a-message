window.onload = () ->

  server = io.connect '/map'

  setup = (city) ->
    server.on city.placeId, (data) ->
      console.log "Received message from #{city.placeId}!"

  setup city for city in allCities
