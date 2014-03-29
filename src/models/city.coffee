mongoose = require 'mongoose'

# Post model
City = new mongoose.Schema(
  name: String
  id: String
  country: String
  location:
    lat: Number
    lng: Number
)

module.exports = mongoose.model 'City', City
