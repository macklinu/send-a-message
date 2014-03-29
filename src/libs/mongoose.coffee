mongoose = require 'mongoose'
autoIncrement = require 'mongoose-auto-increment'


dbUri = process.env.MONGOLAB_URI or
  process.env.MONGOHQ_URL or
  'mongodb://localhost/example'
mongoose.connect dbUri

autoIncrement.initialize mongoose

module.exports = mongoose
