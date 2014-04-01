express = require 'express'
http = require 'http'
stylus = require 'stylus'
assets = require 'connect-assets'
mongoose = require 'mongoose'
restify = require 'express-restify-mongoose'
autoIncrement = require 'mongoose-auto-increment'

models = require './models'

#### Basic application initialization
# Create app instance.
app = express()

# Define Port
app.port = process.env.PORT or process.env.VMC_APP_PORT or 3000

# Config module exports has `setEnvironment` function that sets app settings depending on environment.
config = require "./config"
app.configure 'production', 'development', 'testing', ->
  config.setEnvironment app.settings.env

#### View initialization
# Add Connect Assets.
app.use assets()
# Set the public folder as static assets.
app.use express.static(process.cwd() + '/public')
# Express Session
store = new express.session.MemoryStore
app.use express.cookieParser()
app.use express.session(
  secret: 'shhh'
  store: store
)

# Set View Engine.
app.set 'view engine', 'jade'

# [Body parser middleware](http://www.senchalabs.org/connect/middleware-bodyParser.html) parses JSON or XML bodies into `req.body` object
app.use express.urlencoded()
app.use express.json()

app.configure () ->
  restify.serve app, models.User, restifyOptions
  restify.serve app, models.City, restifyOptions

restifyOptions =
  lowercase: true,
  strict: true

routes = require './routes'
routes(app)

app.server = http.createServer app
socket = require './libs/socket'
socket.start(app.server)

# Export application object
module.exports = app
