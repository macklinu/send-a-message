window.Distance = class Distance

  constructor: ->

  minutesFrom: (@origin, @destination) ->
    R = 6371
    x1 = (@destination.location.lat - @origin.location.lat)
    x2 = (@destination.location.lng - @origin.location.lng)
    dLat = (x1 * Math.PI / 180)
    dLon = (x2 * Math.PI / 180)
    a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.cos(@origin.location.lat * Math.PI / 180) * Math.cos(@destination.location.lat * Math.PI / 180) * Math.sin(dLon / 2) * Math.sin(dLon / 2)
    thing = Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
    c = 2 * thing
    d = R * c / 20.4174
