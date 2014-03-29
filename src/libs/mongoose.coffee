mongoose = require 'mongoose'
autoIncrement = require 'mongoose-auto-increment'

###
db_config = "mongodb://#{config.DB_USER}:#{config.DB_PASS}@#{config.DB_HOST}:#{config.DB_PORT}/#{config.DB_NAME}"
mongoose.connect db_config
###

mongoose.connect 'mongodb://localhost/example'
autoIncrement.initialize mongoose

module.exports = mongoose
