mongoose = require 'mongoose'

# User model
User = new mongoose.Schema(
  name:
    first: String
    last: String
  city: String
  age: Number
)

module.exports = mongoose.model 'User', User
