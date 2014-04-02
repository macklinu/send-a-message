util = require 'util'
events = require 'events'
io = require 'socket.io'

City = require('../models').City

SocketServer = () ->
  events.EventEmitter.call(this)

util.inherits SocketServer, events.EventEmitter

SocketServer::start = (@app) ->
  @io = io.listen @app
  numConnections = 0

  cities = null

  City.find (err, data) ->
    cities = data

  @io.of '/map'
    .on 'connection', (socket) ->
      numConnections++
      console.log "Number of connections: #{numConnections}"

SocketServer::callCity = (city) ->
  @io.of '/map'
    .emit city


module.exports = new SocketServer()
