mongoose = require '../libs/mongoose'
autoIncrement = require 'mongoose-auto-increment'

# Post model
City = new mongoose.Schema(
  name: String
  country: String
  placeId: String
  timezone: String
  location:
    lat: Number
    lng: Number
)

City.plugin autoIncrement.plugin, 'City'

module.exports = mongoose.model 'City', City
