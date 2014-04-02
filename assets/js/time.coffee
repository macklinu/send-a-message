window.Time = class Time

  constructor: (query) ->
    @city = getCity query

  getCity = (query) ->
    param = if query.city then query.city else ''
    c = _.findWhere allCities, placeId: param
    c = if c then c else _.findWhere allCities, placeId: 'annarbor'

  update: ->
    c = @city
    console.log @city
    console.log c
    t = moment()
      .tz c.timezone
    now = if t.second() % 2 is 0 then t.format('h:mm') else t.format('h mm')
    console.log now
    $ "##{c.placeId}-time"
      .text "The time in #{c.name} is #{now}."
