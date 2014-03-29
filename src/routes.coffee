#### Routes
# We are setting up these routes:
#
# GET, POST, PUT, DELETE methods are going to the same controller methods
# We are using method names to determine controller actions for clearness.

User = require './models/user'

module.exports = (app) ->

  # simple session authorization
  checkAuth = (req, res, next) ->
    unless req.session.authorized
      res.statusCode = 401
      res.render '401', 401
    else
      next()

  app.get '/users', (req, res) ->
    User.find (err, users) ->
      if err then console.log err else res.send users

  app.post '/users', (req, res) ->
    console.log 'POST /users: '
    console.log req.body
    user = new User(
      name: req.body.name,
      city: req.body.city,
      age: req.body.age,
    )
    user.save (err) ->
      if err then console.log err else console.log 'created User'
    res.send user

  ###

  app.all '/', (req, res, next) ->
    routeMvc('index', 'index', req, res, next)

  app.all '/:controller', (req, res, next) ->
    routeMvc(req.params.controller, 'index', req, res, next)

  app.all '/:controller/:method', (req, res, next) ->
    routeMvc(req.params.controller, req.params.method, req, res, next)

  app.all '/:controller/:method/:id', (req, res, next) ->
    routeMvc(req.params.controller, req.params.method, req, res, next)

  app.all '/*', (req, res) ->
    console.warn "error 404: ", req.url
    res.statusCode = 404
    res.render '404', 404

  ###

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
