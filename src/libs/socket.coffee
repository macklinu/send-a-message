util = require 'util'
events = require 'events'
io = require 'socket.io'
osc = require 'node-osc'

City = require('../models').City

SocketServer = () ->
  events.EventEmitter.call(this)

util.inherits SocketServer, events.EventEmitter

SocketServer::start = (@app) ->
  @io = io.listen @app
  numConnections = 0

  # constants
  IP_ADDRESS = '23.21.132.4'
  OSC_SERVER_PORT = 3333
  OSC_CLIENT_PORT = 12345

  client = new osc.Client IP_ADDRESS, OSC_CLIENT_PORT
  oscServer = new osc.Server OSC_SERVER_PORT, IP_ADDRESS

  setup = (socket, city) ->
    id = city.placeId
    oscServer.on "/#{id}", (msg, info) ->
      console.log "Received bang from #{id}!"
      socket.emit id

  cities = null

  City.find (err, data) ->
    cities = data

  @io.of '/map'
    .on 'connection', (socket) ->
      console.log cities
      numConnections++
      console.log "Number of connections: #{numConnections}"
      setup socket, city for city in cities

SocketServer::callCity = (city) ->
  @io.of '/map'
    .emit city


module.exports = new SocketServer()
