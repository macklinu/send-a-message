width = 960
height = 500
rotate = [0, 0]
graticule = d3.geo.graticule()

projection = d3.geo.azimuthalEquidistant()
     .scale(300)
     .translate([width / 2, height / 2])
     .precision(0.5)
     .clipAngle(180 - 1e-3)
     .rotate(rotate)

path = d3.geo.path()
    .projection(projection)

m0 = null
o0 = null

awesomeData = null

annArbor = [-83.716090, 42.291173]
annArborProjection = projection(annArbor)

drag = d3.behavior.drag()
    .on 'dragstart', () ->
      # Adapted from http://mbostock.github.io/d3/talk/20111018/azimuthal.html and updated for d3 v3
      proj = projection.rotate()
      m0 = [d3.event.sourceEvent.pageX, d3.event.sourceEvent.pageY]
      o0 = [-proj[0], -proj[1]]
    .on 'drag', () ->
      if m0
        m1 = [d3.event.sourceEvent.pageX, d3.event.sourceEvent.pageY]
        o1 = [o0[0] + (m0[0] - m1[0]) / 4, o0[1] + (m1[1] - m0[1]) / 4]
        console.log [-o1[0], -o1[1]]
        projection.rotate [-o1[0], -o1[1]]

      # Update the map
      path = d3.geo.path().projection projection

      d3.selectAll 'path'
      .attr 'd', path

      plotCoordinates()

svg = d3.select 'body'
      .append 'svg'
      .attr 'width', width
      .attr 'height', height
      .call drag

svg.append 'defs'
    .append 'path'
    .datum type: 'Sphere'
    .attr 'id', 'sphere'
    .attr 'd', path

svg.append 'use'
    .attr 'class', 'stroke'
    .attr 'xlink:href', '#sphere'

svg.append 'use'
    .attr 'class', 'fill'
    .attr 'xlink:href', '#sphere'

svg.append 'path'
    .datum graticule
    .attr 'class', 'graticule'
    .attr 'd', path

d3.json 'json/plate0.json', (error, plates) ->
  svg.insert 'path', '.graticule'
      .datum topojson.feature plates, plates.objects.plates0
      .attr 'class', 'land'
      .attr 'd', path

d3.json 'json/array-of-places.json', (error, data) ->
  console.error error if error
  console.log data
  awesomeData = data
  plotCoordinates()

plotCoordinates = () ->
  coords = getCoords awesomeData[5]

  projection
      .rotate [-coords[0], 0]
      .center [0, coords[1]]

  svg.selectAll 'circle'
      .data awesomeData
      .enter()
      .append 'circle'
      .attr 'cx', (d) -> getProjection(d)[0]
      .attr 'cy', (d) -> getProjection(d)[1]
      .attr 'class', (d) -> d.id
      .attr 'r', 10
      .on 'click', (d) ->
        d3.select(this)
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

getCoords = (d) ->
  [d.location.longitude, d.location.latitude]

getProjection = (d) ->
  projection getCoords d
