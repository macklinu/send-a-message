window.Time = class Time

  constructor: (query) ->
    @city = getCity query

  getCity = (query) ->
    param = if query.city then query.city else ''
    c = _.findWhere allCities, placeId: param
    c = if c then c else _.findWhere allCities, placeId: 'annarbor'

  update: ->
    t = moment()
      .tz @city.timezone
    now = if t.second() % 2 is 0 then t.format('h:mm:ss') else t.format('h mm ss')
    $ "##{@city.placeId}-time"
      .text "The time in #{@city.name} is #{now}."
    if @currentMinute isnt t.minute()
      @currentMinute = t.minute()
      true
    else
      false
