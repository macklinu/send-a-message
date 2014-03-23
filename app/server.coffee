# require modules
express = require("express")
app = express()
server = require("http").createServer(app)
io = require("socket.io").listen(server)
osc = require("node-osc")
coffeescript = require('coffee-script').register()

# constants
IP_ADDRESS = "127.0.0.1"
OSC_SERVER_PORT = 3333
OSC_CLIENT_PORT = 12345

# set up osc
client = new osc.Client(IP_ADDRESS, OSC_CLIENT_PORT)
oscServer = new osc.Server(OSC_SERVER_PORT, IP_ADDRESS)

# general app server
server.listen 3000

app.set 'view engine', 'jade'
app.engine('jade', require('jade').__express)
app.get "/", (req, res) ->
  res.render __dirname + "/views/index"

# socket server
io.sockets.on "connection", (socket) ->
  oscServer.on "/number", (msg, info) ->
    console.log msg
    socket.emit "number",
      number: msg[1]
  socket.on "send message", (data) ->
    client.send "/toMax", JSON.stringify(data)
