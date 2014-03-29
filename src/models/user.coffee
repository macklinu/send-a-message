mongoose = require '../libs/mongoose'
autoIncrement = require 'mongoose-auto-increment'

# User model
User = new mongoose.Schema(
  name:
    first: String
    last: String
  city: String
  age: Number
)

User.plugin autoIncrement.plugin, 'User'

module.exports = mongoose.model 'User', User
