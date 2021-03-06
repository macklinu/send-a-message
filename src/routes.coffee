#### Routes
# We are setting up these routes:
#
# GET, POST, PUT, DELETE methods are going to the same controller methods
# We are using method names to determine controller actions for clearness.

socket = require './libs/socket'

module.exports = (app) ->

  cities = [
    'annarbor',
    'berlin',
    'athens',
    'portland',
    'london',
    'fredrikstad',
    'belfast',
    'detroit',
    'boston'
  ]

  # simple session authorization
  checkAuth = (req, res, next) ->
    unless req.session.authorized
      res.statusCode = 401
      res.render '401', 401
    else
      next()

  app.get '/', (req, res, next) ->
    routeMvc('index', 'index', req, res, next)

  app.all '/:controller', (req, res, next) ->
    routeMvc(req.params.controller, 'index', req, res, next)

  for city in cities
    do (city) ->
      app.post "/max/#{city}", (req, res, next) ->
        socket.callCity city
        res.statusCode = 200
        res.type 'application/json'
        res.json sent: city

  app.all '/*', (req, res) ->
    console.warn "error 404: ", req.url
    res.statusCode = 404
    res.render '404', 404

# render the page based on controller name, method and id
routeMvc = (controllerName, methodName, req, res, next) ->
  controllerName = 'index' if not controllerName?
  controller = null
  try
    controller = require "./controllers/" + controllerName
  catch e
    console.warn "controller not found: " + controllerName, e
    next()
    return
  data = null
  if typeof controller[methodName] is 'function'
    actionMethod = controller[methodName].bind controller
    actionMethod req, res, next
  else
    console.warn 'method not found: ' + methodName
    next()
