server = io.connect '/map'

setup = (city) ->
  id = city.placeId
  server.on id, (data) ->
    console.log id
    d3.selectAll "##{id}"
      .transition()
      .duration 500
      .ease 'back'
      .attr 'r', 20
      .style 'fill', '#b48585'
      .transition()
      .duration 1500
      .ease 'bounce'
      .attr 'r', 10
      .style 'fill', '#551111'

setup city for city in allCities
