window.onload = () ->

  triggerUpdate = () ->
    @time.update()
    _.map allCities, (c) ->
      if c isnt @city
        distance = new window.Distance().minutesFrom @city, c
        destTime = moment()
          .tz @city.timezone
          .add 'm', distance
          .format 'h:mm'
        $ "span##{c.placeId}-span-name"
          .text " #{c.name}"
        $ $ "span##{c.placeId}-dest-time"
          .text " #{destTime}"
        document.getElementById("#{c.placeId}-span-name").style.fontWeight = "bold";

  @time = new Time query
  param = if query.city then query.city else ''
  @city = _.findWhere allCities, placeId: param
  triggerUpdate()
  setInterval triggerUpdate, 1000
