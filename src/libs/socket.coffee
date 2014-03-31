util = require 'util'
events = require 'events'
io = require 'socket.io'
http = require 'http'

SocketServer = () ->
  events.EventEmitter.call(this)

util.inherits SocketServer, events.EventEmitter

SocketServer::start = (app) ->
  io = io.listen app
  numConnections = 0

  io.of '/map'
    .on 'connection', (socket) ->
      numConnections++
      console.log "Number of connections: #{numConnections}"
      socket.emit 'berlin', data: 'world'

module.exports = new SocketServer()
